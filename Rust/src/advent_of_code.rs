pub mod year_2023;

#[derive(Debug)]
pub struct Day {
    pub year: u32,
    pub day: u32,
    pub problem_1: fn(&str) -> String,
    pub problem_2: fn(&str) -> String
}