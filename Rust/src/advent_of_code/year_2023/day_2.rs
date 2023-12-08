use crate::advent_of_code::Day;

use lazy_static::lazy_static;
use regex::Regex;
use std::cmp::max;

pub(super) static DAY: Day = Day {
    year: 2023,
    day: 2,
    problem_1,
    problem_2
};

fn problem_1(input_string: &str) -> String {
    let ret_val: u32 = input_string.lines()
        .map(|x| parse_game(x))
        .filter(is_possible_game)
        .map(|game| game.id)
        .sum();
    ret_val.to_string()
}
fn problem_2(input_string: &str) -> String {
    let ret_val: u32 = input_string.lines()
        .map(|x| parse_game(x))
        .map(|game| maximal_round(&game.rounds))
        .map(|(r, g, b)| r * g * b)
        .sum();
    ret_val.to_string()
}

lazy_static! {
    static ref GAME_ID_REGEX: Regex = Regex::new(r"^Game (?<gameid>\d+): (.*)$").unwrap();
    static ref RED_REGEX: Regex = Regex::new(r"(\d+) red").unwrap();
    static ref GREEN_REGEX: Regex = Regex::new(r"(\d+) green").unwrap();
    static ref BLUE_REGEX: Regex = Regex::new(r"(\d+) blue").unwrap();
}

#[derive(Debug)]
struct Round {
    red: u32,
    green: u32,
    blue: u32
}

#[derive(Debug)]
struct Game {
    id: u32,
    rounds: Vec<Round>
}

fn extract_game_id(input_line: &str) -> u32 {
    let Some(caps) = GAME_ID_REGEX.captures(input_line) else { return 0; };
    String::from(&caps[1]).parse().expect("Game id is not a number!!")
}

fn parse_colour(regex: &Regex, input_field: &str) -> u32 {
    let Some(caps) = regex.captures(input_field) else { return 0; };
    String::from(&caps[1]).parse().expect("Red is not a number!!")
}

fn parse_red(input_field: &str) -> u32 {
    parse_colour(&RED_REGEX, input_field)
}

fn parse_green(input_field: &str) -> u32 {
    parse_colour(&GREEN_REGEX, input_field)
}

fn parse_blue(input_field: &str) -> u32 {
    parse_colour(&BLUE_REGEX, input_field)
}

fn parse_round(input_field: &str) -> Round {
    let red = parse_red(input_field);
    let green = parse_green(input_field);
    let blue = parse_blue(input_field);
    Round {
        red: red,
        green: green,
        blue: blue
    }
}

fn parse_game(input_line: &str) -> Game {
    let game_id = extract_game_id(input_line);
    let rounds: Vec<Round> = input_line.split(":")
        .skip(1)
        .next()
        .expect("should be present!!")
        .split(";")
        .map(|x| parse_round(x.trim()))
        .collect();

    Game {
        id: game_id,
        rounds: rounds
    }
}

fn maximal_round(round: &Vec<Round>) -> (u32, u32, u32) {
    round.iter()
        .fold((0, 0, 0), |(r, g, b), round| (max(r, round.red), max(g, round.green), max(b, round.blue)))
}

fn is_possible_round(round: &Round) -> bool {
    round.red <= 12 && round.green <= 13 && round.blue <= 14
}

fn is_possible_game(game: &Game) -> bool {
    game.rounds.iter().all(is_possible_round)
}