# 10 Functional Programming

일급함수 (first-class functions) 조건

- 심볼 할당 가능
- 함수를 argument 로 pass 가능
- 함수를 return 가능

### 10. 1 Motivation

1. 함수형
   정의: 함수를 argument 로 갖는 함수
   ex) lapply()

- 함수형의 장점 (over copy and paste)
  - 간편하다.
  - 결측치가 존재하는 경우, 한 부분만 수정하면 됌.
  - 열이 많아도 상관 없음.
  - 열마다 동일한 작업을 수행하므로 실수할 일이 없음.
  - subset 에 적용하기도 쉬움.

2.  클로저
    정의: 함수를 반환하는 함수를 사용해서 만든 함수
    ex)

    ````R
    missing_fixer <- function(na_value) {
    function(x) {
    x[x == na_value] <- NA
    x
    }
    }
    fix_missing_99 <- missing_fixer(-99)
    fix_missing_999 <- missing_fixer(-999)

        fix_missing_99(c(-99, -999))
        # [1] NA -999
        fix_missing_999(c(-99, -999))
        # [1] -99 NA
        ```
    ````

- extra argument
  ```r
  fix_missing <- function(x, na.value) {
      x[x == na.value] <- NA
      x
  }
  # 모든 상황에서 적용 안됌.
  ```

3. 함수 리스트
   같은 argument 로 호출되는 함수가 많을 때 사용하면 유용.
   ex)
   `r summary <- function(x) { funs <- c(mean, median, sd, mad, IQR) lapply(funs, function(f) f(x, na.rm=T)) } `

### 10.2 Anonymous functions

함수는 당연, 심볼 역시 객체이다. 불필요한 심볼을 할당할 필요가 없다.

- 함수 이름 사용 필요 없는 경우
  ```r
  lapply(mtcars, function(x) length(unique(x)))
  ```
- 클로저 생성하는 경우

1. 무명함수도 함수입니다. 함수 구성요소 3가지

- formals()
- body()
- environment()

```r
formals(function(x=4) g(x)+h(x))
# $x
# [1] 4
body(function(x=4) g(x)+h(x))
# g(x) + h(x)
environment(function(x=4) g(x)+h(x))
# <environment: R_GlobalEnv>
```

2. 호출 시 주의할 점
   꼭 괄호

```r
(function(x) 3)()
```

### 10.3 Closures

클로저의 명칭 이유: 부모 함수의 환경을 enclose(포함) 하고 그것의 변수에 모두 접근 가능하기 때문.

```r
power <- function(exponent) {
    function(x) {
        x ^ exponent
    }
}
square <- power(2)
square(2)
# [1] 4
square(4)
# [1] 16
cube <- power(3)
cube(2)
# [1] 8
cube(4)
# [1] 64
```

클로저의 부모 환경은 부모 함수의 환경이다. 클로저의 환경은 부모 함수의 실행환경이다. 함수의 실행환경은 실행 후에 사라지기 마련인데, 클로저는 실행환경을 저장한다. 따라서, R의 거의 모든 함수는 클로저이다. 전역환경이나 패키지환경을 일반적으로 저장하기 때문이다. 예외로는 primitive functions 들이 있다. C 코드로 작성되었기 때문에 환경과는 무관하다.

1. Function factories
   함수 공장: 새로운 함수를 생성하는데 사용하는 함수

```r
draw <- function(x) {
    function(FUN, ...) FUN(x, ...)
}
draw.FUN <- draw(x = rnorm(1000))
draw.FUN( FUN = hist, col = topo.color(4)[2], ... )
draw.FUN( FUN = hist, col = topo.color(4)[4], ... )
# draw.FUN 은 부모 함수인 draw 의 실행환경을 포함하고 있으므로
# x = rnorm(1000) 이 일정한 값을 갖는다.
# draw 는 함수 공장.
# draw.FUN 은 클로저.
```

2. Mutable State
   `<<-` 을 통해 부모환경의 심볼의 값을 바꿔준다. 각 클로저의 부모환경 내 심볼 값을 변경하는걸 관찰할 수 있다.

```r
new_counter <- function() {
    i <- 0
    function() {
        i <<- i + 1
        i
    }
}
counter_one <- new_counter()
counter_two <- new_counter()
counter_one()
# [1] 1
counter_one()
# [1] 2
counter_two()
# [1] 1
```

### 10.3 Lists of functions

함수 리스트의 장점

- 함수 간 성능 비교
- 함수형이랑 같이 사용 가능. 자료의 요약을 출력할때 편함.

1. Moving lists of functions to the global environment
   단점: 함수 리스트에서 `$` 을 계속 덧붙여 꺼내 쓸때마다 코드가 장황해진다.
   보안 1. 일시적으로 이용 시: `with()` 2. 좀 더 길계 사용 시: `attach()`, `detach()`, `search()` 3. 아주 길게 사용 시: `list2env()`, `rm()`

cf. `force()` 사용 이유
argument 의 evaluation 을 바로 저장. lazy evaluation 을 방지.

### Case Study: 수치 적분

first-class function 의 특성을 살려 수치 함수를 generalize 하는 과정.

# 11 Functionals

### 11.1`lapply()`

R에서는 반복문의 사용을 가급적 피해야 함. 느리고, 직관적이지 않기 때문. 함수형을 사용한다고 무조건 빨라지는건 아님을 주의.

`lapply()` 작동방식

- 결과를 저장할 리스트 객체 생성
- 각 리스트 원소를 함수 `f` 적용
- 결과값을 리스트에 채움

`lapply()` 는 데이터프레임도 적용 가능

- return 값을 리스트가 아닌 데이터프레임으로 받으려면
  ```r
  mtcars[] <- lapply(mtcars, function(x) x/mean(x))
  ```

`FUN` 의 첫번째 외 argument 로 `X`의 각 원소를 pass 하기 위해선 anonymous function 을 사용하면 된다.

```r
trims <- c(0, 0.1, 0.2, 0.5)
dat <- rcauchy(1000)
unlist(lapply(trims, function(trim) mean(dat, trim = trim)))
```

1. Looping patterns

   - loop over the elements: `for (x in xs)`
     비추. 매우 느림. 왜냐면 R 의 copy & paste 특성으로 모든 원소를 복사해야함.
   - loop over the numeric indices: `for (i in seq_along(xs))`
     그나마 추천.
   - loop over the names: `for (nm in names(xs))`
     이것도 쓸만함.

   근데 모든 루프는 함수형으로 대체 가능하다는거 잊지마.

### 11.2 Friends of lapply()

1. Vector output: `sapply`, `vapply`
   `vapply` 는 `sapply` 에 output type specification 을 추가한 함수이다. 에러가 날때 메시지가 구체적이라 함수 내부에서 이용할때 유용하다. 그와 반대로 `sapply` 는 원소끼리 데이터 타입이 다르거나 길이가 다르면 에러 메시지 없이 리스트를 반환한다.

- `sapply`
  `unlist(lapply())` 와 동일함
- `vapply`
  empty vector(또는 matrix) 을 만들고 그 안에 element 의 함숫값을 채워놓음

2. Map
   입력항목이 두개 이상인 경우. `Map()` 에선 입력항목이 `...` 이다.

3. Rolling computations
   반복문을 사용해 사용자 함수형 구현. 우선 내부를 for loop 으로 구현하고 함수형으로 변환이 가능하면 수정해주자.

### 11.3 Manipulating matrices and data frames

1. Matrix and array operations

   - `apply()`: vector, array, list 모두 반환
     - X
     - MARGIN
     - FUN
     - ...
   - `sweep()`: 통계량의 벡터로 행렬의 행이나 열에 같은 계산을 반복할때. `apply` 쓰면 배수 관계가 안맞음.
   - `outer()`: 외적

2. `tapply()`: group apply
   `sapply(split(vector, group), FUN)`

### 11.4 Manipulating lists

1. `Reduce()`
   벡터의 원소 2개를 순차적으로 `f`에 씌운다.
2. Predicate Functionals
   `predicate`: 서술하다, 단정하다. 데이터의 값이 조건을 만족하는지 검사한다.

- `Filter()`
- `Find()`
- `Position()`
- `where()`
  ```r
  where <- function(f, x) {
      vapply(x, f, logical(1))
  }
  ```

### 11.5 Mathematical functionals

- `integrate()`
- `uniroot()`
- `optimise()`
