use std::collections::HashMap;
use lazy_static::lazy_static;

pub(super) static DIGITS: [char; 10] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
lazy_static!{
pub(super) static ref DIGIT_WORDS: HashMap<&'static str, u32> =
    [
          ("zero", 0)
        , ("one", 1)
        , ("two", 2)
        , ("three", 3)
        , ("four", 4)
        , ("five", 5)
        , ("six", 6)
        , ("seven", 7)
        , ("eight", 8)
        , ("nine", 9)
    ].iter().cloned().collect();
}

pub(super) static SYMBOLS: [char; 15] = ['!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/'];

pub(super) fn is_digit(chr: char) -> bool {
    match as_digit(chr) {
        Some(_) => true,
        None => false
    }
}

pub(super) fn is_symbol(chr: char) -> bool {
    for symbol in SYMBOLS {
        if chr == symbol {
            return true;
        }
    }
    false
}

pub(super) fn as_digit(chr: char) -> Option<u32> {
    for digit in DIGITS {
        if chr == digit {
            return Some(digit.to_digit(10).expect("Digit from static list is not a digit!!"));
        }
    }
    None
}