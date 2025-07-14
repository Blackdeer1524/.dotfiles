import re
import pyperclip
from PIL import ImageGrab
from pix2text import Pix2Text
import sys
from PIL import Image


def replace_double_dollars(text):
    pattern = r"\$\$(.*?)\$\$"
    replaced_text = re.sub(pattern, r"\\[\1\\]", text, flags=re.MULTILINE | re.DOTALL)
    return replaced_text


def replace_singular_dollars(text):
    pattern = r"\$(.*?)\$"
    replaced_text = re.sub(pattern, r"\\(\1\\)", text, flags=re.MULTILINE | re.DOTALL)
    return replaced_text


def get_image_from_clipboard():
    try:
        # Attempt to get image from clipboard using Pillow
        image = ImageGrab.grabclipboard()
        if image.mode != "RGB":
            image = image.convert("RGB")
        return image
    except Exception as e:
        print(f"Error reading image from clipboard: {e}")
        sys.exit(1)


def main():
    # Get image from clipboard
    if len(sys.argv) < 2:
        print("Usage: python parse_latex.py <image_path>")
        sys.exit(1)
    image_path = sys.argv[1]

    total_configs = {
        "text_formula": {"languages": ("ru", "en")},
    }
    p2t = Pix2Text.from_config(total_configs=total_configs, device="cpu")

    try:
        image = Image.open(image_path)
        if image.mode != "RGB":
            image = image.convert("RGB")
    except Exception as e:
        print(f"Error reading image from path: {e}")
        sys.exit(1)

    try:
        # Extract text from image
        extracted_text = p2t.recognize(image, return_text=True)

        if not extracted_text.strip():
            print("No text detected in the image.")
            sys.exit(1)

        extracted_text = replace_singular_dollars(
            replace_double_dollars(extracted_text)
        )
        # Copy extracted text to clipboard
        pyperclip.copy(extracted_text)
        print("Text successfully extracted and copied to clipboard.")

    except Exception as e:
        print(f"Error processing image with Pix2Text: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
