import subprocess
import sys
import os
import tempfile

TITLE = "ScreenOCR"
ICON = "gnome-screenshot"

LATEX_OPT = "latex"
LANGUAGES = ["eng+rus", LATEX_OPT, "eng", "rus", "deu"]

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
CONFIG_PATH = os.path.expanduser(f"{SCRIPT_DIR}/.screenocr_lang")
VENV_PATH = os.path.join(SCRIPT_DIR, ".venv")
REQ_PATH = os.path.join(SCRIPT_DIR, "requirements.txt")


def ensure_venv():
    if not os.path.exists(VENV_PATH):
        print("Creating virtual environment...")
        subprocess.run([sys.executable, "-m", "venv", VENV_PATH], check=True)
    pip_path = os.path.join(VENV_PATH, "bin", "pip")
    if os.path.exists(REQ_PATH):
        print("Installing dependencies from requirements.txt...")
        subprocess.run([pip_path, "install", "-r", REQ_PATH], check=True)


def load_last_lang():
    if os.path.exists(CONFIG_PATH):
        with open(CONFIG_PATH, "r") as f:
            last = f.read().strip()
            if last in LANGUAGES:
                return last
    return LANGUAGES[0]


def save_last_lang(lang):
    with open(CONFIG_PATH, "w") as f:
        f.write(lang)


def select_language():
    default_lang = load_last_lang()
    # Put default_lang first in yad entry-text
    entry_text = [default_lang] + [l for l in LANGUAGES if l != default_lang]
    yad_cmd = [
        "yad",
        "--width",
        "300",
        "--entry",
        "--title",
        TITLE,
        "--image",
        ICON,
        "--window-icon",
        ICON,
        "--button=ok:0",
        "--button=cancel:1",
        "--text",
        "Select language:",
        "--entry-text",
    ] + entry_text
    proc = subprocess.run(yad_cmd, stdout=subprocess.PIPE)
    if proc.returncode in [252, 1]:
        sys.exit(0)
    lang = proc.stdout.decode().strip()
    save_last_lang(lang)
    return lang


def main():
    ensure_venv()

    os.environ["LC_ALL"] = "en_US.UTF-8"
    lang = select_language()
    with tempfile.TemporaryDirectory() as tmpdir:
        scr_img = os.path.join(tmpdir, "temp_ocr")
        img_path = scr_img + ".png"
        txt_path = scr_img + ".txt"
        # Take screenshot
        result = subprocess.run(["scrot", "-s", img_path, "-q", "100"])
        if result.returncode != 0:
            print("couldn't capture a screenshot")
            sys.exit(1)

        # Postprocess image
        if lang == LATEX_OPT:
            subprocess.run(
                [
                    f"{SCRIPT_DIR}/.venv/bin/python3",
                    os.path.join(SCRIPT_DIR, "parse_latex.py"),
                    img_path,
                ],
            )
        else:
            subprocess.run(
                ["mogrify", "-modulate", "100,0", "-resize", "400%", img_path]
            )
            # OCR
            subprocess.run(["tesseract", "-l", lang, img_path, scr_img])
            # Copy to clipboard
            with open(txt_path, "rb") as f:
                subprocess.run(["xsel", "-bi"], input=f.read())
            # Play sound
        subprocess.run(
            ["play", "/usr/share/sounds/freedesktop/stereo/window-attention.oga"]
        )

if __name__ == "__main__":
    main()
