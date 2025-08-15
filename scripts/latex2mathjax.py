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
    )

def replace_dashes(text: str) -> str:
    return text.replace("--", "‒")


def process(text: str) -> str:
    text = replace_double_dollars(text)
    text = replace_singular_dollars(text)
    text = replace_special(text)
    text = replace_dashes(text)
    return text


all_input = pyperclip.paste()
result = process(all_input)
pyperclip.copy(result)
print(result)
