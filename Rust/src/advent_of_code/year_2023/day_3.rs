use crate::advent_of_code::Day;
use crate::advent_of_code::year_2023::util::is_digit;
use crate::advent_of_code::year_2023::util::is_symbol;

use std::vec;

type XCoordinate = usize;
type YCoordinate = usize;
type Length = usize;
type Coordinate = (XCoordinate, YCoordinate);
type NumberPosition = (Coordinate, Length);

pub(super) static DAY: Day = Day {
    year: 2023,
    day: 3,
    problem_1,
    problem_2
};

fn problem_1(input_string: &str) -> String {
    let coordinator = parse_coordinator(input_string);
    let nums = find_numbers(&coordinator);
    let part_nums = nums.iter()
        .map(|n| as_part_number(&coordinator, n))
        .flatten();
    //format!("{:?}", part_nums)
    String::new()
}

fn problem_2(input_string: &str) -> String {
    let coordinator = parse_coordinator(input_string);
    format!("{:?}", surroundings_of(&coordinator, &((1, 9),3)))
}

struct Coordinator {
    data: Vec<String>,
    width: usize
}

impl Coordinator {
    fn chr_at(&self, (x, y): &Coordinate) -> char {
        let row = self.data.iter().skip(y - 1).next().expect("y out of range!!");
        row.chars().skip(x - 1).next().expect("x out of range!!") // TODO is this right??
    }

    fn num_at(&self, (pos, length): &NumberPosition) -> usize {
        let mut acc: usize = 0;
        for n in 0..u32::try_from(*length).unwrap() {
            acc = acc * 10;
            acc = acc + usize::try_from(self.chr_at(pos).to_digit(10).expect("not a digit!!")).unwrap();
        }
        acc
    }
}

fn parse_coordinator(input_string: &str) -> Coordinator {
    let lines: Vec<String> = input_string.lines().map(String::from).collect();
    let width: usize = lines.get(0).expect("No lines!!").len();
    Coordinator { data: lines, width }
}

fn surroundings_of(coordinator: &Coordinator, num: &NumberPosition) -> Vec<Coordinate> {
    let height = coordinator.data.len();
    c![(x, y),
        for x in num.0.0.saturating_sub(1) .. num.0.0 + num.1 + 1,
        for y in num.0.1.saturating_sub(1) .. num.0.1 + 2,
        if x < coordinator.width && y < height]
}

fn as_part_number(coordinator: &Coordinator, num: &NumberPosition) -> Option<usize> {
    if surroundings_of(coordinator, num).iter().any(|pos| is_symbol(coordinator.chr_at(pos))) {
        let the_num = coordinator.num_at(num);
        println!("{}", the_num);
        return Some(the_num);
    }
    None
}

fn find_numbers(coordinator: &Coordinator) -> Vec<NumberPosition> {
    let mut ret: Vec<NumberPosition> = Vec::new();
    let mut start: XCoordinate = 0;
    let mut is_counting: bool = false;
    for (y, line) in coordinator.data.iter().enumerate() {
        println!("We're on line {}", y);
        for(x, chr) in line.chars().enumerate() {
            let on_digit = is_digit(chr);
            if !is_counting && on_digit {
                println!("Started counting at x={}", x);
                start = x;
            }
            if is_counting && !on_digit {
                println!("Finished counting at x={}", x);
                let length = x - start;
                ret.push(((start, y), length));
            }
            is_counting = on_digit;
        }

        if is_counting {
            let length = coordinator.width - start;
            ret.push(((start, y), length));
        }
        is_counting = false;
    }
    ret
}
