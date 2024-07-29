# layout_convert.py

import sys

# Таблица для преобразования текста с английской раскладки на русскую и наоборот
TRANSLIT_TABLE = str.maketrans(
    'qwertyuiop[]asdfghjkl;\'zxcvbnm,./?QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?',
    'йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,?'
)

REVERSE_TRANSLIT_TABLE = str.maketrans(
    'йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,?',
    'qwertyuiop[]asdfghjkl;\'zxcvbnm,./?QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?'
)

def convert_text(text):
    if any(char in 'qwertyuiop[]asdfghjkl;\'zxcvbnm,./?QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?' for char in text):
        return text.translate(TRANSLIT_TABLE)
    else:
        return text.translate(REVERSE_TRANSLIT_TABLE)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        input_text = sys.argv[1]
        output_text = convert_text(input_text)
        print(output_text, end='')
    else:
        print("No input text provided", end='')

