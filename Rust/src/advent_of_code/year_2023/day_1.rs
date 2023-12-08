use std::collections::HashMap;
use lazy_static::lazy_static;
use std::iter::Iterator;

use crate::advent_of_code::Day;
use crate::advent_of_code::year_2023::util::DIGITS;
use crate::advent_of_code::year_2023::util::DIGIT_WORDS;
use crate::advent_of_code::year_2023::util::as_digit;

fn combine_digits(d0: Option<u32>, d1: Option<u32>) -> Option<u32> {
    Some(d0? * 10 + d1?)
}

fn first_digit(input_string: &str) -> Option<u32> {
    for chr in input_string.chars() {
        for digit in DIGITS {
            if chr == digit {
                return Some(chr.to_digit(10).expect("Digit isn't actually a digit!!"));
            }
        }
    }
    None
}

fn last_digit(input_string: &str) -> Option<u32> {
    input_string.chars().rev().fold(None, |acc, chr| match acc {
        Some(x) => Some(x),
        None => as_digit(chr)
    })
}

fn extract_digits(input_string: &str) -> Option<u32> {
    combine_digits(first_digit(input_string), last_digit(input_string))
}

fn first_digit_word(input_string: &str) -> Option<u32> {
    for n in 0..input_string.len() {
        for prefix in DIGIT_WORDS.keys() {
            if input_string[n..].starts_with(prefix) {
                return DIGIT_WORDS.get(prefix).copied();
            }
        }
    }
    None
}

fn last_digit_word(input_string: &str) -> Option<u32> {
    for n in (0..input_string.len()).rev() {
        for prefix in DIGIT_WORDS.keys() {
            if input_string[n..].starts_with(prefix) {
                return DIGIT_WORDS.get(prefix).copied();
            }
        }
    }
    None
}

fn extract_digit_words(input_string: &str) -> Option<u32> {
    combine_digits(first_digit_word(input_string), last_digit_word(input_string))
}

fn problem_1(input_string: &str) -> String {
    let ret: u32 = input_string.split("\n")
        .map(|x| extract_digits(x))
        .flatten()
        .sum();
    ret.to_string()
}

fn problem_2(input_string: &str) -> String {
    let ret: u32 = input_string.split("\n")
        .map(|x| extract_digit_words(x))
        .flatten()
        .sum();
    ret.to_string()
}

pub(super) static DAY: Day = Day {
    year: 2023,
    day: 1,
    problem_1,
    problem_2
};