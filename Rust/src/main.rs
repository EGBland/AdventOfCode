#[macro_use(c)]
extern crate cute;

use std::fs;

mod advent_of_code;

use advent_of_code::year_2023;

fn read_input_file(year: u32, day: u32) -> String {
    let path = format!("inputs/{}/day{}.txt", year, day);
    fs::read_to_string(path).expect("Couldn't read file!!")
}

fn main() {
    println!("Year 2023");
    for day in year_2023::DAYS {
        let input_string = read_input_file(day.year, day.day);
        let p1_result = (day.problem_1)(&input_string);
        let p2_result = (day.problem_2)(&input_string);

        println!("\t Day {}\t{}\t{}", day.day, p1_result, p2_result);
    }
}
