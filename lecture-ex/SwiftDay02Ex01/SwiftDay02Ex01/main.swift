//
//  main.swift
//  SwiftDay02x01
//
//  Created by 도민준 on 1/23/25.
//


import Foundation

/*
 // 단문 복문, 한줄에 복문으로 작성시 ;사용
 let 안녕 = "안녕하세요."
 var hello = "Hello, World!"
 print(hello, terminator: "")
 print(안녕)
 
 // 변수는 값을 변경 할 수 있다.
 hello = "안녕 세상"
 print(hello, terminator: "\n")
 // 특수문자 \n \t \r \a ...
 // 터미네이터 속성의 기본값(default)은 terminator: "\n"
 */

/*
 // 이전 에제를 주석 처리 하고 다음 예제 실습
 // readLine()으로 데이터 입력
 
 // 성명과 나이를 입력 받아서 출력하는 예제
 // 나이의 5년 후 나이를 출력하라.
 // 성명은 상수로 선언
 // 나이는 변수로 선언
 
 // 변수나 상수는 맨위에 선언하는 것이 일반적이다.
 // 성명과 나이를 입력 받을 변수 선언.
 
 var name: String = ""
 var age: Int = 0
 
 print("성명 입력: ", terminator: "")
 name = readLine() ?? ""
 print("나이 입력: ", terminator: "")
 age = Int(readLine() ?? "0") ?? 0
 
 // 변수는 값을 바꿔 줄 수 있다.
 age = age + 5
 
 print("\(name)님의 나이는 \(age)입니다.")
 */

/*
 // 옵셔널의 값 확인 (언래핑)
 var name: String? = nil
 
 print("성명 입력: ", terminator: "")
 name = readLine()
 
 // let userName = name!
 // let userName = name ?? "noname"
 // print("성명은 " + userName + "입니다.")
 
 if let userName = name {
 print("성명은 " + userName + "입니다.")
 } else {
 print("이름을 한글로 입력하세요")
 }
 */


/*
 print("첫 번째 숫자를 입력하세요:")
 let input1 = readLine()
 print("두 번째 숫자를 입력하세요:")
 let input2 = readLine()
 print("세 번째 숫자를 입력하세요:")
 let input3 = readLine()
 
 if let num1 = Int(input1 ?? ""), let num2 = Int(input2 ?? ""), let num3 = Int(input3 ?? "") {
 var largest = num1
 var middle = num1
 var smallest = num1
 
 if num2 > largest {
 largest = num2
 }
 if num3 > largest {
 largest = num3
 }
 
 if (num1 < num2 && num1 > num3) || (num1 > num2 && num1 < num3) {
 middle = num1
 } else if (num2 < num1 && num2 > num3) || (num2 > num1 && num2 < num3) {
 middle = num2
 } else {
 middle = num3
 }
 
 smallest = num1 + num2 + num3 - largest - middle
 
 print("큰 수: \(largest)")
 print("중간 수: \(middle)")
 print("작은 수: \(smallest)")
 } else {
 print("숫자를 정확히 입력하세요.")
 }
 */


// if 조건문 사용 방법
/*
 식별자를 선언할때 모든 문자 사용 가능. 단, 특수문자, 공백, 숫자로 시작 하지 말기
 의사코드 (정해진 규칙은 없다. 논리적으로 내 나름대로 작성)
 1.나이를 입력 받는다.
 1.1 나이를 저장 할 변수 선언
 1.2 "나이 입력" 지문
 1.3 나이를 입력 받는다.
 2.나이가 18 보다 크면 성인이라고 출력. (18 초과)
 3.나이가 18이하면 미성년이라고 출력. (이하)
 */

// 프로그래머스 사이트의 문제 풀어보기

/*
var age: Int = 0
var result = "미성년"

print("나이 입력: ",terminator: "")
age = Int(readLine() ?? "0") ?? 0

if age > 18 {
    result = "성인"
}

print("당신의 나이는 \(age)이고 \(result)입니다.")
*/


/*
// 의사 코드
/*
 1. 각각 다른 정수 3개 입력
    1.1 변수 선언: num1, num2, num3
    1.2 정수 3개 순서 대로 입력 (옵셔널 언랩핑 한다.)
 2. 각각 비교해서 제일 큰수, 중간수 , 작은수를 판별한다.
    2.1 결과 변수 선언: 큰수(max), 중간(mid), 작은수(small)
    2.2 입력 받은 수중 2개를 비교해서 큰것은 max에 저장
    2.3 작은 것은 min에 저장
    2.4 입력 받은 나머지 수를 max 나 min과 비교
        2.4.1 max보다 크다면 기존 max는 min이 되고 나머지 숫자가 max
        2.4.2 max보다 작다면 min과 비교하여 min보다 작다면 나머지 min 기존 min은 mid
        2.4.3 max보다 크지 않고 min 보다 작지 않다면 나머지 숫자가 mid
 3. 출력한다.
 */

// 입력 받을 변수 선언 또는 let으로 선언해서 상수로 받을 수 있다.
var num1: Int?, num2: Int?, num3: Int?
var max = 0;
var mid = 0;
var min = 0;

// 입력(언랩핑)
print("각각 다른 정수 3개 입력: ", terminator: "")
num1 = Int(readLine() ?? "0") ?? 0
num2 = Int(readLine() ?? "0") ?? 0
num3 = Int(readLine() ?? "0") ?? 0

print("입력 받은 정수는 \(num1!), \(num2!), \(num3!) 입니다.")

if num1! > num2! {
    max = num1!
    min = num2!
} else {
    max = num2!
    min = num1!
}


// 비교하지 않은 나머지 숫자인 num3을 max와 min과 각각 비교
if max < num3! {
    mid = max
    max = num3!
} else if min > num3! {
    mid = min
    min = num3!
} else {
    mid = num3!
}

print("max:\(max), mid:\(mid), min:\(min)")
*/

/*
let grade = Int(readLine() ?? "0") ?? 0

switch grade {
case 90...100:
    print("A학점")
case 80..<90:
    print("B학점")
case 70..<80:
    print("C학점")
case 60..<70:
    print("D학점")
default:
    print("F학점")
}
*/


/*
let size = 10
var total: Int = 0

for num in 1...size{
    print("\(num)", terminator: num < 10 ? " + " : " = ")
    total += num
}

print(total)
*/

var total = 1
var num1 = 0
var num2 = 1


print("피보나치 수열: 0, 1,", terminator: "")

for i in 1...8{
    
    var num = num1 + num2
    total += num
    
    num1 = num2
    num2 = num
    
    print(" \(num)", terminator: i == 8 ? "\n" : ",")
}

print("합계: \(total)")
