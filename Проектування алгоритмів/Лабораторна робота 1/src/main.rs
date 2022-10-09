use std::{fs::File, io::{Read, Write}, str::from_utf8};
const NL: u8 = b'\n';
const SPACE: u8 = b' ';
const BUF_LEN: usize = 32;

enum ReadNum {
    Error,
    EndFile,
    EndLine(i32),
    Number(i32),
}

fn main() {
    let type_0 = "type_0.txt";
    let type_1 = "type_1.txt";
    let type_2 = "type_2.txt";

    let mut buffer: [u8; BUF_LEN] = [0; BUF_LEN];
    loop {
        if let Err(e) = split(&mut buffer, type_0, type_1, type_2) {
            eprintln!("{}", e);
            return;
        }
        match join(&mut buffer, type_0, type_1, type_2) {
            Ok(res) => if res {
                break;
            },
            Err(e) => {
                eprintln!("{}", e);
                return;
            },
        };
    }
    println!("Завершено");
}

fn join(buffer: &mut [u8], type_0: &str, type_1: &str, type_2: &str) -> Result<bool, String> {
    let mut file_0 = match File::create(type_0) {
        Ok(f) => f,
        Err(e) => return Err(format!("При відкритті файлу <{}> виникла помилка: {}", type_0, e.to_string())),
    };
    let mut file_1 = match File::open(type_1) {
        Ok(f) => f,
        Err(e) => return Err(format!("При відкритті файлу <{}> виникла помилка: {}", type_1, e.to_string())),
    };
    let mut file_2 = match File::open(type_2) {
        Ok(f) => f,
        Err(e) => return Err(format!("При відкритті файлу <{}> виникла помилка: {}", type_2, e.to_string())),
    };
    let mut e1 = false;
    let mut e2 = false;
    let mut r1 = true;
    let mut r2 = true;
    let mut num1 = i32::MIN;
    let mut num2 = i32::MIN;
    let mut l1 = false;
    let mut l2 = false;
    let mut seek = false;
    let mut end1 = true;
    let mut end2 = true;

    loop {
        if !e1 && r1 {
            match read_num_space(&mut file_1, buffer) {
                ReadNum::Error => return Err(format!("При читанні з файлу <{}> виникла помилка", type_1)),
                ReadNum::EndFile => e1 = true,
                ReadNum::EndLine(n) => {
                    num1 = n;
                    l1 = true;
                    end1 = false;
                },
                ReadNum::Number(n) => {
                    num1 = n;
                    l1 = false;
                    end1 = false;
                },
            };
        }
        if !e2 && r2 {
            match read_num_space(&mut file_2, buffer) {
                ReadNum::Error => return Err(format!("При читанні з файлу <{}> виникла помилка", type_2)),
                ReadNum::EndFile => e2 = true,
                ReadNum::EndLine(n) => {
                    num2 = n;
                    l2 = true;
                    end2 = false;
                },
                ReadNum::Number(n) => {
                    num2 = n;
                    l2 = false;
                    end2 = false;
                },
            };
        }
        if e1 && e2 {
            break;
        }
        if seek {
            if let Err(e) = file_0.write(&[NL]) {
                return Err(format!("При запису файлу <{}> виникла помилка: {}", type_0, e.to_string()));
            };
        } else {
            seek = true;
        }
        if !e1 && e2 { // Закінчився 2-й файл
            if let Err(e) = file_0.write(num1.to_string().as_bytes()) {
                return Err(format!("При запису файлу <{}> виникла помилка: {}", type_0, e.to_string()));
            };
            r1 = true;
            r2 = false;
        } else if e1 && !e2 { // Закінчився 1-й файл
            if let Err(e) = file_0.write(num2.to_string().as_bytes()) {
                return Err(format!("При запису файлу <{}> виникла помилка: {}", type_0, e.to_string()));
            };
            r1 = false;
            r2 = true;
        } else if num1 < num2 {
            if let Err(e) = file_0.write(num1.to_string().as_bytes()) {
                return Err(format!("При запису файлу <{}> виникла помилка: {}", type_0, e.to_string()));
            };
            r1 = true;
            r2 = false;
        } else {
            if let Err(e) = file_0.write(num2.to_string().as_bytes()) {
                return Err(format!("При запису файлу <{}> виникла помилка: {}", type_0, e.to_string()));
            };
            r1 = false;
            r2 = true;
        }
        if r1 && l1 && !e2{
            num1 = i32::MAX;
            r1 = false;
        } else if r2 && l2 && !e1 {
            num2 = i32::MAX;
            r2 = false;
        }
        if !r1 && !r2 && l1 && l2 && num1 == i32::MAX && num2 == i32::MAX {
            r1 = true;
            r2 = true;
        }
    }
    if (end1 && !end2) || (!end1 && end2) {
        return Ok(true);
    }
    Ok(false)
}

fn split(buffer: &mut [u8], type_0: &str, type_1: &str, type_2: &str) -> Result<(), String> {
    let mut file_0 = match File::open(type_0) {
        Ok(f) => f,
        Err(e) => return Err(format!("При відкритті файлу <{}> виникла помилка: {}", type_0, e.to_string())),
    };
    let mut file_1 = match File::create(type_1) {
        Ok(f) => f,
        Err(e) => return Err(format!("При відкритті файлу <{}> виникла помилка: {}", type_1, e.to_string())),
    };
    let mut file_2 = match File::create(type_2) {
        Ok(f) => f,
        Err(e) => return Err(format!("При відкритті файлу <{}> виникла помилка: {}", type_2, e.to_string())),
    };
    let mut last: i32 = i32::MIN;
    let mut first = true;
    let mut nl_1 = false;
    let mut nl_2 = false;
    let mut seek_1 = false;
    let mut seek_2 = false;
    loop {
        let i = match read_num_br(&mut file_0, buffer) {
            Some(i) => i,
            None => break,
        };
        if last > i {
            if first {
                seek_1 = false;
            } else {
                seek_2 = false;
            }
            first = !first;
        }
        if first {
            if nl_1 && !seek_1 {
                if let Err(e) = file_1.write(&[NL]) {
                    return Err(format!("При запису файлу <{}> виникла помилка: {}", type_1, e.to_string()));
                };
            } else {
                nl_1 = true;
            }
            if seek_1 {
                if let Err(e) = file_1.write(&[SPACE]) {
                    return Err(format!("При запису файлу <{}> виникла помилка: {}", type_1, e.to_string()));
                };
            } else {
                seek_1 = true;
            }
            if let Err(e) = file_1.write(i.to_string().as_bytes()) {
                return Err(format!("При запису файлу <{}> виникла помилка: {}", type_1, e.to_string()));
            };
        } else {
            if nl_2 && !seek_2 {
                if let Err(e) = file_2.write(&[NL]) {
                    return Err(format!("При запису файлу <{}> виникла помилка: {}", type_2, e.to_string()));
                };
            } else {
                nl_2 = true;
            }
            if seek_2 {
                if let Err(e) = file_2.write(&[SPACE]) {
                    return Err(format!("При запису файлу <{}> виникла помилка: {}", type_2, e.to_string()));
                };
            } else {
                seek_2 = true;
            }
            if let Err(e) = file_2.write(i.to_string().as_bytes()) {
                return Err(format!("При запису файлу <{}> виникла помилка: {}", type_2, e.to_string()));
            };
        }
        last = i;
    }
    Ok(())
}

fn read_num_br(file: &mut File, buffer: &mut [u8]) -> Option<i32> {
    for i in 0..BUF_LEN {
        let count = match file.read(&mut buffer[i..i+1]) {
            Ok(count) => count,
            Err(_) => return None,
        };
        if buffer[i] == NL || count == 0 {
            if i == 0 {
                return None;
            }
            return match from_utf8(&buffer[0..i]) {
                Ok(s) => {
                    match s.parse::<i32>() {
                        Ok(int) => Some(int),
                        Err(_) => None,
                    }
                },
                Err(_) => None,
            }
        }
    }
    None
}

fn read_num_space(file: &mut File, buffer: &mut [u8]) -> ReadNum {
    for i in 0..BUF_LEN {
        let count = match file.read(&mut buffer[i..i+1]) {
            Ok(count) => count,
            Err(_) => return ReadNum::Error,
        };
        if buffer[i] == SPACE || count == 0 {
            if i == 0 {
                return ReadNum::EndFile;
            }
            return match from_utf8(&buffer[0..i]) {
                Ok(s) => {
                    match s.parse::<i32>() {
                        Ok(int) => {
                            if count == 0 {
                                ReadNum::EndLine(int)
                            } else {
                                ReadNum::Number(int)
                            }
                        },
                        Err(_) => ReadNum::Error,
                    }
                },
                Err(_) => ReadNum::Error,
            }
        } else if buffer[i] == NL {
            if i == 0 {
                return ReadNum::Error;
            }
            return match from_utf8(&buffer[0..i]) {
                Ok(s) => {
                    match s.parse::<i32>() {
                        Ok(int) => ReadNum::EndLine(int),
                        Err(_) => ReadNum::Error,
                    }
                },
                Err(_) => ReadNum::Error,
            }
        }
    }
    ReadNum::EndFile
}