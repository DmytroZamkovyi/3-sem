const SIZE: usize = 8;
const LIMIT: usize = 8;

enum RBFSRes {
    Ok ([usize; SIZE]),
    Err,
}


enum LDFSRes {
    Success ([usize; SIZE], usize, usize),
    Cutoff (usize, usize),
    DeadEnd (usize, usize),
}


struct State
{
    board: [usize; SIZE],
    child_state: Vec<State>,
}


impl State {
    fn new (arr: [usize; SIZE]) -> State {
        return State {
            board: arr,
            child_state: Vec::new(), 
        };
    }

    fn expand_state(&mut self) {
        for i in 0..SIZE {
            let row = self.board[i];
            for j in 0..SIZE {
                let mut new_state = State::new(self.board);
                if j != row {
                    new_state.board[i] = j;
                    self.child_state.push(new_state);
                }
            }
        }
    }

    fn copy (&mut self) -> State {
        let mut new_state = State::new(self.board);
        return new_state;
    }
}

fn arr_out (arr: [usize; SIZE]) {
    
    for i in 0..SIZE {
        let mut out = "".to_string();
        for j in 0..SIZE {
            if j == arr[i] {
                out += &"[Q]";
            } else {
                out += &"[ ]";
            }
        }
        println!("{}", out);
    }
}

fn main()
{
    // let input: [usize; SIZE] = [3, 5, 7, 1, 6, 0, 2, 4];
    let input: [usize; SIZE] = [1, 3, 6, 4, 1, 4, 6, 6];
    println!("Input:");
    arr_out(input);
    println!("LDFS:");
    match ldfs(input, 0, 0, 8, 0, 0)
    {
        LDFSRes::Success (k, _, _) => arr_out(k),
        LDFSRes::DeadEnd (c, t) => println!("Dead end\nCount of dead_ends - {}\nTotal states - {}", c, t),
        LDFSRes::Cutoff (c, t) => println!("Not found at this depth\nCount of dead_ends - {}\nTotal states - {}", c, t),
    };
    println!("RBFS:");
    match rbfs(&mut State::new(input), 64, 0) {
        RBFSRes::Ok(e) => arr_out(e),
        RBFSRes::Err => println!("Error"),
    }

}


fn f2(arr: [usize; SIZE]) -> usize {
    let mut result: usize = 0;
    for i in 1..SIZE {
                for j in 0..SIZE {
                    if arr[i] + i == arr[j] + j {
                        result += 1;
                    }
                    if abs(arr[i], i) == abs(arr[j], j) {
                        result += 1;
                    }
                    if arr[i] == arr[j] {
                        result += 1;
                    }
                }
            }
            return result;
}


fn min(arr: Vec<usize>) -> (usize, usize) {
    let mut key = 0;
    let mut min = arr[key];
    for i in 1..arr.len() {
        if arr[i] < min {
            min = arr[i];
            key = i;
        }
    }
    return (min, key);
}


fn rbfs (state: &mut State, f_limit: usize, depth: usize) -> RBFSRes
{
    if check_state(state.board) {
        return RBFSRes::Ok(state.board);
    }
    if depth >= LIMIT {
        return RBFSRes::Err;
    }
    state.expand_state();
    let mut f: Vec<usize> = Vec::new();
    for i in 0..state.child_state.len() {
        f.push(f2(state.child_state[i].board))
    }
    loop {
        let best_value: usize;
        let best_index: usize;
        (best_value, best_index) = min(f.clone());
        let mut best_state = state.child_state[best_index].copy();
        if best_value > f_limit {
            return RBFSRes::Err;
        }
        state.child_state.remove(best_index);
        f.remove(best_index);

        let alt = min(f.clone());
        if let RBFSRes::Ok(k) = rbfs(&mut best_state, f_limit.min(alt.0), depth + 1) {
            return RBFSRes::Ok(k);
        }
    }
}


fn ldfs (arr: [usize; SIZE], curent_line: usize, depth: usize, max_depth: usize, count_of_dead_ends: usize, total_states: usize) -> LDFSRes
{
    let mut count: usize = count_of_dead_ends;
    let mut total: usize = total_states + 1;
    if depth == max_depth || curent_line > SIZE - 1 {
        if check_state(arr) {
            return LDFSRes::Success (arr, count, total);
        } else {
            count += 1;
            if depth == max_depth {
                return LDFSRes::DeadEnd (count, total)
            } else {
                return LDFSRes::Cutoff (count, total)
            }
        }
    }

    match ldfs(arr, curent_line + 1, depth, max_depth, count, total) {
        LDFSRes::Success (k, c, t) => {
            return LDFSRes::Success (k, c, t);
        },
        LDFSRes::Cutoff (c, t) => {
            count = c;
            total = t;
        },
        LDFSRes::DeadEnd (c, t) => {
            count = c;
            total = t;
        },
    }

    for i in 0..SIZE {
        if i != arr[curent_line] {
            let mut new_arr = arr;
            new_arr[curent_line] = i;
            match ldfs(new_arr, curent_line + 1, depth + 1, max_depth, count, total) {
                LDFSRes::Success (k, c, t) => {
                    return LDFSRes::Success (k, c, t);
                },
                LDFSRes::Cutoff (c, t) => {
                    count = c;
                    total = t;
                },
                LDFSRes::DeadEnd (c, t) => {
                    count = c;
                    total = t;
                },
            }
        }
    }

    return LDFSRes::Cutoff (count, total);
}


fn check_state (arr: [usize; SIZE]) -> bool
{
    for _i in 0..SIZE {
        if find(arr) {
            return false;
        }
    }

    for i in 0..SIZE-1 {
        for j in i+1..SIZE {
            if abs(arr[j], arr[i]) == abs(j, i) {
                return false;
            }
        }
    }

    return true;
}


fn abs (int1: usize, int2: usize) -> usize
{
    if int2 > int1 {
        return int2 - int1;
    } else {
        return int1 - int2;
    }
}


fn find (arr: [usize; SIZE]) -> bool
{
    for i in 0..SIZE-1 {
        for j in i+1..SIZE {
            if arr[i] == arr[j] {
                return true;
            }
        }
    }
    return false;
}