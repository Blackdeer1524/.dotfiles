import pyperclip
import re


def replace_double_dollars(text):
    pattern = r"\$\$(.*?)\$\$"
    replaced_text = re.sub(pattern, r"\\[\1\\]", text, flags=re.MULTILINE | re.DOTALL)
    return replaced_text


def replace_singular_dollars(text):
    pattern = r"\$(.*?)\$"
    replaced_text = re.sub(pattern, r"\\(\1\\)", text, flags=re.MULTILINE | re.DOTALL)
    return replaced_text


def replace_special(text: str) -> str:
    return (
        text.replace("\\Im", "\\operatorname{Im}")
        .replace("\\Identity", "\\operatorname{id}")
        .replace("\\spec", "\\operatorname{spec}")
        .replace("\\rk", "\\operatorname{rk}")
        .replace("\\Hom", "\\operatorname{Hom}")
    )

def replace_dashes(text: str) -> str:
    return text.replace("--", "‒")


def replace_textit(text: str) -> str:
    pattern = r"\\textit\{([^}]+)\}"
    replaced_text = re.sub(pattern, r"<b>\1</b>", text)
    return replaced_text


def replace_matrix(text: str) -> str:
    pattern = r"\\Matrix\{([^}]+)\}"
    replaced_text = re.sub(pattern, r"\\operatorname{M}_{\1}(\\mathbb{R})", text)
    return replaced_text


def replace_newlines(text: str) -> str:
    # Replace multiple consecutive newlines (2 or more) with double newlines
    text = re.sub(r'\n{2,}', '\n\n', text)
    # Replace single newlines with spaces
    text = re.sub(r'(?<!\n)\n(?!\n)', ' ', text)
    return text


def process(text: str) -> str:
    text = replace_double_dollars(text)
    text = replace_singular_dollars(text)
    text = replace_special(text)
    text = replace_dashes(text)
    text = replace_textit(text)
    text = replace_matrix(text)
    text = replace_newlines(text)
    return text


all_input = pyperclip.paste()
result = process(all_input)
pyperclip.copy(result)
print(result)
