---
layout: post
title: Notes on Advanced R Programming
---
# Introduction
This note is based on a lecture about R programming language. The content resource is from [advanced R by Hadley Wickham](https://adv-r.hadley.nz/). The notes were taken in year Spring 2021 and are uploaded just for myself in order to not forget about the language.

# Fundamentals

### 2.2 Binding Basics
1. names vs values

```r
# names = symbol = reference , values = object
x <- c(1,2,3) 
y <- x
obj_addr(x)
obj_addr(y)
```
2. binding
'<-' = bind / refer / point to
3. name rules
`` 사용시 룰 깰 수 있음

### 2.3 copy-on-modify
```r
# 1. what happens when copy
x <- c(1,2,3)
cat(tracemem(x),"\n")
y <- x
y[[3]] <- 3
obj_addr(x)
obj_addr(y)
y[2] <- 10
# function
f <- function(a) {
    a
}
z <- f(x)
# list
# shallow copy vs deep copy
l1 <- list(1,2,3)
tracemem(l1)
l2 <- l1
l2[[3]] <- 4
ref(l1, l2) # 모든 원소가 변한게 아니라 shallow copy
# data frame
# copy-on-modify by column vs copy-on-modify by row
d1 <- data.frame(x=c(1,5,6), y=c(2,4,3))
tracemem(d1)
d2 <- d1
d2[,2] <- d2[,2]*2 # by column
ref(d1, d2) 
d3 <- d1
d3[1,] <- d3[1,]*2
ref(d1,d3)
# copy-on-modify loop twice
d4 <- d1
ref(d1, d4)
d4[,2] <- d4[,2]*2
# character vector
# global string pool
x <- c("a","a","abc","d")
ref(x)
ref(x, character=TRUE) # global string pool 을 사용해야 주소값이 보임
```
### 2.4 Object Size
```r
x <- c(1,2,3)
obj_size(x)
y <- list(x,x,x)
obj_size(y) # list ref 80B
obj_size("banana banana banana") # global string pool
obj_size(x,y) # shared size 160B
t <- c(4,5,6)
z <- list(t,t,t)
obj_size(z)
obj_size(x,z) # none-shared size 80B + 160B = 240B
obj_size(1:3) == obj_size(1:10)# altrep - 1과 3만 저장
```
### 2.5 Modify-in-place
```r
# objects with single binding
v <- c(1,2,3)
tracemem(v)
v[[3]] <- 4
ref(v)
# environments
e1 <- rlang::env(a=1, b=2, c=3)
tracemem(e1)
e2 <- e1
e2$c <- 4
```

# Data
### 3.2 Atomic Vectors
```r
# scalar
x <- c(1,2,3)
typeof(x)
y <- 1:3
typeof(y)
# missing values
NA == NA
x <- c(1,2,3); x==NA
NA^0 # exception 1
NA | TRUE # exception 2
NA & FALSE # exception 3
is.na(x)
# testing and coercion
# testing
is.logical(); is.integer(); is.double(); is.character();
is.vector(); is.atomic(); is.numeric() # avoid using this
x <- c(1,2,3)
y <- c(a=1,b=2,c=3)
attr(y, "name") <- c("g","h","l")
attributes(y)
is.numeric(x) # 이거 쓸바엔 is.integer || is.double
is.vector(y)
check.vector <- function(a) {
    is.atomic(a) || is.list(a)
} 
check.vector(y)
# coercion
# character -> double -> integer -> logical
typeof(c(FALSE))
typeof(c(FALSE, 1L))
typeof(c(FALSE, 1L, 1))
typeof(c(FALSE, 1L, 1, "1"))
as.logical(c(FALSE, 1L, 1, "1")) # failed coercion - NA
```

### 3.3 Attributes
1. attributes
```r
a <- 1:3
attributes(a)
attr(a,"x") <- "abcdef"
str(a)
attr(a,"y") <- 4:6
str(attributes(a))
a <- structure(
    1:3,
    x="abcdef",
    y=4:6
)
str(attributes(a))
names(a)
```
2. names
```r
x <- c(a=1,b=2,c=3)
x <- 1:3
names(x) <- c("a","b","c")
names(x)
x <- setNames(1:3, c("a","b")) # names NULL 이 아닌 NA
x <- unname(x)
```
3. dimensions
```r
x <- matrix(1: 6, nrow=2, ncol=3)
y <- structure(
    1:6,
    dim=c(2,3)
)
y
y <- array(1:12, c(2,3,2))
y
z <- 1:6
dim(z) <- c(3,2)
class(z); z
dim(z) <- NULL
class(z); z
z <- c(a=1,b=2,c=3)
is.null(dim(z))
matrix(1:3, ncol=1)
matrix(1:3, nrow=1)
array(1:3, 3)
```
### 3.4 S3 atomic vectors
1. factor: built on top of integer vectors with attributes 'class=factor', 'levels='
```r
x <- factor(c("a","b","c","d"))
attributes(x)
typeof(x) 
sex <- c("m","m","m")
sex_factor <- factor(sex, levels=c("m","f"))
table(sex_factor)
grade <- ordered(x, levels=c("a","b","d","c")) # ordered: ordered factor
grade; attributes(grade)
unclass(sex_factor)
cbind(sex_factor) # factors are not character vectors
```
2. Dates: built on top of double vectors with attributes 'class=Date'
```r
today <- Sys.Date(); today 
typeof(today)
attributes(today)
unclass(today)
```
3. Date-times: built on top of atomic (double) vector with attributes 'class=POSIXct', 'tzone='
```r
now_ct <- as.POSIXct("2018-08-01 22:00", tz="UTC"); now_ct
typeof(now_ct)
attributes(now_ct)
attributes(structure(now_ct, tzone="Asia/Tokyo"))
```
4. Durations: built on top of doubles with attribtues 'class=difftime' , 'units='
```r
one_week_1 <- as.difftime(1, units="weeks"); one_week_1
typeof(one_week_1)
attributes(one_week_1)
```
### 3.5 Lists
1. lists
```r
l1 <- list(
    1:3,
    "a",
    c(T,F,F),
    c(2.3,5.9)
)
l1; typeof(l1); str(l1)
l2 <- list(l1); l2
typeof(l2); str(l2)
l3 <- list(list(1,2),c(3,4)); str(l3)
l4 <- c(list(1,2),c(3,4)); str(l4) # coerce vector -> list
l5 <- c(list(1,2),list(3,4)); str(l5)
```
2. testing & coercion
```r
ypeof(list()); is.list(); as.list(); unlist();
as.vector() # list 도 벡이므로 atomic vector 로 바꾸려면,
typeof(as.vector(unlist(list(1:3))))
```
3. Matrices & Arrays
```r
dim(l1) <- c(2,2)
attributes(l1); str(l1); l1
l1[[2,2]]
dim(l1) <- c(1,2,2)
```

### 3.6 Data frames & Tibbles
1. data frames: built on top of lists with attributes 'name', 'class', 'row.names'
```r
df1 <- data.frame(x=1:3, y=letters[1:3]); df1
typeof(df1); attributes(df1); str(df1)
df1 <- data.frame(x=1:3, y=letters[1:3], stringsAsFactors=FALSE); df1; str(df1)
```
2. tibbles: built on top of lists
```r
library(tibble)
df2 <- tibble(x=1:3, y=letters[1:3]); df2
typeof(df2); attributes(df2); str(df2) # tibble 은 stringsAsFactors 인자가 필요 없다.
```
3. row names
```r
df3 <- data.frame(
    age=c(35,27,18),
    hair=c("blond","brown","black"),
    row.names=c("Bob","Susan","Sam")
)
attributes(df3); str(df3)
rownames(df3) <- c("David","Josh","Ronald"); df3
```
4. list & matrix
```r
df <- data.frame(x=1:3)
df$y <- list(1:2, 1:3, 1:4)
attributes(df); str(df)
df$z <- matrix(1:9, nrow=3); df
attributes(df); str(df)
df$t <- df1
attributes(df); str(df)
```

### 3.7 NULL
```r
typeof(NULL)
length(NULL)
attributes(NULL)
```

# Subsetting

### 4.2 Multiple elements
1. Atomic vectors
```r
x <- c(2.1,4.2,3.3,5.4)
x[c(3,1)] # positive vector
x[-c(3,1)] # negative vector
x[c(T,T,F,F)]; x[x>3]; x[c(T, F)]; x[c(T,F,NA)] # logical vector
x[] # nothing returns orginial
x[0] # zero returns zero-length vector
names(x) <- c(letters[1:4]); x[c("d","c")] # named vectors can be subset by character vectors
x[factor("d")] # factors in subset are integer vectors
```
2. Lists
```r
l1 <- list(1:3, letters[1:3], c(T,T,F))
typeof(l1[1]); typeof(l1[[1]])
l1[c(1,2)]; l1[[1]]
l1[c(T,F,T)]
l1[]
l1[0]
names(l1) <- c(letters[1:3]); l1[a[2]]
```
3. Matrices & Arrays
```r
a <- matrix(1:9, nrow=3)
colnames(a) <- c("A","B","C"); class(a); typeof(a)
a[1:2,]; class(a)
a[c(T,F,T),c("B","A")]; class(a)
a[0,-2]; class(a)
class(a[1,]); str(a[1,]) # dimension 이 줄으면 자동적으로 class 변동
a
a[1:2] # vector 로도 subset 가능
select <- matrix(c(1,1,3,1,2,2), ncol=2); select # matrix 로도 subset 가능 
a[select]; class(a[select])
```
4. Data frame
```r
df <- data.frame(x=1:3, y=3:1, z=letters[1:3]); df
df[1] # 디폴트 column
df[df$x==2]; df[df$x==2,]
df[c("x","z")]
class(df[1,]); str(df[1,]) # 매트릭스와 달리 class 변동 x
str(a[1, ,drop=FALSE]) # dimension 을 잃지 않는 방법
# factor 도 drop argument 존재 - levels 을 잃음
# factor 에서 drop 많이 사용하면 character vector 을 사용해야 하는 사인
z <- factor(c("a","b"))
z[1]
z[1, drop=TRUE]
```

### 4.3 Single Element
```r
# *[[y]] = *$y
x <- list(1:3,"a",4:6); x
x[[1]][2]
var <- "cyl"; mtcars$var; mtcars[[var]] # mtcars[["var"]]=NULL 출력 $ 말고 [[]] 사용
str(mtcars[[c(1,3)]])
x[[c(3,2)]]
mtcars$m; mtcars$mpg # $ 는 partial matching 가능
mtcars$c; mtcars$ca; mtcars$cy
mtcars[[NULL]]
mtcars[NULL]
NULL[]
NULL[0]
list()[["X"]]
```

### 4.4 Subsetting & Assignment
```r
# assignment: modify selected values
x <- 1:5
x[c(1,2)] <- c(101,102)
x
x <- list(a=1,b=2)
x[["b"]] <- NULL; x; str(x) # list 이면 NULL assignment 로 [[i]] 지울 수 있음
x["a"] <- list(NULL); x; str(x) # list(NULL) assignment 로 NULL 값을 할당 가능

mtcars[] <- lapply(mtcars, as.integer) # subset with nothing can be useful in assignments
is.data.frame(mtcars)
mtcars
```

### 4.5 Applications
1. lookup: character matching
```r
x <- c("m","f","u","f","f","m","m")
lookup <- c(m="Male", f="Female", u=NA)
lookup[x]; unname(lookup[x])
```
2. matching & merging
```r
grades <- c(1,2,2,3,1) # match
info <- data.frame(
    grades=3:1,
    desc=c("Excellent","Good","Poor"),
    fail=c(F,F,T)
)
id  <- match(grades, info$grades); id 
?match
info[id,]
grades <- data.frame(grades=grades) # merge
merge(grades, info) 
```
3. sample
```r
mtcars
mtcars[sample(10),] # sample(n, k): random permutation of 1:n then select k
mtcars[sample(10, 4),]
mtcars[sample(10, 4, replace=TRUE),]
```
4. ordering: returns how to order vector in integer vector
```r
x <- c("a","c","b", NA) # default: decreasing & na.last=TRUE
y <- c("b","c","a")
order(x); order(y)
x[order(x)]
```
5. expanding aggregated counts: 데이터프레임  행/열을  여러번  출력시
```r
df <- data.frame(x=c(2,4,1),y=c(9,11,6),n=c(3,5,1)); df
df[rep(1:nrow(df),df$n),]
df[rep(1:nrow(df),c(3,5,1)),]
```
6. removing columns from dataframe
```r
df$n <- list(NULL); df
df[["n"]] <- NULL; df
```
7. which: returns vector of index which is TRUE
```r
x <- 1:5 >= 4; x; x1 <- which(x); x1
```
8. intersect: `intersect()`, `&`
9.  union: `union()`, `|`
10. setdiff: `setdiff()`, `* & !*`

# Control Flow

### 5.2 Choices
```r
x1 <- if (TRUE) 1 else 2; x1
# invalid inputs: mostly single TRUE or FALSE
if ("x") 1
if (0) 1 else 2
if (logical()) 1
if (NA) 1
if (c(TRUE,FALSE)) 1 # 첫번째 요소만 사용됨
# vectorised if
x <- 1:10
ifelse(x%%2==0, "even", "odd")
y <- c(1:5, NA, 6:10)
ifelse(y%%2==0, "even", "odd") # NA 는 NA 를 return
# switch
x_option <- function(x) {
    switch(x,
        a="option1",
        b="option2",
        c="option3",
        stop("Invalid `x`value") # last component should always throw error
    )
}
x_option("a"); x_option("d")
legs <- function(x) {
    switch(x,
        cow=,
        horse=,
        dog=4,
        human=,
        chicken=2,
        stop("Unknown input")
    )
} # switch statement with empty inputs
legs("cow")
```
### 5.3 Loops
```r
for (i in 1:3) {
    print(i)
}
i <- 100; for (i in 1:3) {}; print(i) # for assigns item to current env
# common pitfalls
means <- c(1,50,20)
out <- vector("list", length(means))
for (i in 1:length(means)) {
    out[[i]] <- rnorm(10, means[[i]])
}; out # output container 을 미리 만들지 않으면 느리다.
means <- c(); means # means <- NULL 과 동일
out <- vector("list", length(means)); out
for (i in 1:length(means)) {
  out[[i]] <- rnorm(10, means[[i]])
}; out # for : decreasing order 도 가능
seq_along(means)
for (i in seq_along(means)) {
    out[[i]] <- rnorm(10, means[[i]])
}; out
# S3 객체 iterate 할 때 주의
xs <- as.Date(c("2020-01-01", "2010-01-01"))
for (x in xs) {
    print(x)
}
for (i in seq_along(xs)) {
    print(xs[[i]])
}
# while & repeat
vals <- 1:3
for (i in seq_along(vals)) print(i)
i <-1 
while (i < 4) {
    print(i)
    i <- i + 1
}
i <- 1 
repeat {
    print(i)
    i <- i + 1
    if (i > 3) break
}
```

# Function

### 6.1 Introduction

### 6.2 Function fundamentals

1. Function Components

- `formals()`: arguments
- `body()`: body
  - `attributes()` vs `body()`
- `environment()`: environment

2. Primitive Functions
   base 패키지 중 C 코드로 작성된 함수 - R 함수가 아니어서 components 적용 안됨.

- `typeof()`
  - builtin functions
  - special functions

3. First-class Functions

- first-class function condition
  - symbol
  - argument
  - return function as value
- anonymous function

4. Invoking a Function

- `do.call()`

### 6.3 Function Composition

- nesting & save intermediate results
- piping: binary operator `%>%`

### 6.4 Lexical Scoping

- scoping: finding value bound with a name
- four rules

1. Name masking
   차례대로 위를 탐색하면서 refer
2. Functions versus variables
   function 도 객체이므로 name masking 과정에서 variable 로 인식
3. A fresh start
   body 안에 있는 객체는 실행환경이 사라질 때 같이 사라진다.
4. Dynamic lookup
   환경에서 찾는 경우가 있다. 방지하기 위해 `emptyenv()` 로 함수의 환경을 바꿔주면 된다.

### 6.5 Lazy Evaluation

- "lazily evaluated"

1. Promises: object binding formal arguments matching values in invoked function environment

- expression
- environment
- value

2. Default Arguments
   evaluation environment - function environment (default) vs global environment (user)
3. Missing Arguments
   `missing()`: default environment vs user environment

### 6.6 ...(dot-dot-dot)

`...` : passing additional arguments to another function
`..N` : passing elements of `...` by position
`list(...)` : evaluates `...` into a list

- 단점

1. hard to understand the function
2. typos are difficult to notice

### 6.7 Exiting a Function

1. Implicit vs Explicit returns
2. Invisible Values
   `invisible()`, `withVisible()`
3. Errors
   `stop()`
4. Exit handlers
   `on.exit(..., add=TRUE)`

### 6.8 Function Forms

1. Rewriting to Prefix Form
2. Prefix Form
3. Infix Functions
4. Replacement Functions
5. Special Forms

# Environments

### 7.1 Introduction

### 7.2 Environment Basics

- difference between Environment and List
  - every name is unique
  - not ordered
  - environment has a parent
  - do not copy-on-modify

1. Basics

- create env
  `env()` vs `new.env()`
- checking elements
  `env_names()`, `ls(env, all.names=TRUE)`, `names()`, `lapply(env,"[[",1)`, `lapply(env,"[",1)`
- environments can contain themselves
  but better should use `env_print()`

2. Important envrionments

- `current_env()` vs `global_env()`
- `identical()` : comparing environments
- `parent.env()`, `env_parent()`, `env_parents()` : Parents
  implement lexical scoping to find environment
  `empty_env()` has no parent - 모든 환경의 상위환경의 마지막은 empty environment 이다.
  `env_parents(env, last=empty_env())` shows all the parent environments.

4. Super Assignment, <<-
   modifies existing variable in current environment
5. Getting and Setting

- `$`
- `[[`
- not `[`
- `env_get()` : returns error if binding doesn't exist. Others return `NULL`
- `env_poke()`, `env_bind()` : setting
- `env_has` : boolean for getting binding
- `env_unbind()` : removing elements from environment
  객체가 환경에서 제거 되었다고 메모리에서도 제거 된 것은 아니다.

### 7.3 Recursing Over Environments

```r
where <- function(name, env=caller_env()) {
    if (identical(env, empty_env())) {
        # base
        stop("Can't find ", name, call.=FALSE)
    } else if (env_has(env, name)) {
        # success
        env
    } else {
        # recursive
        where(name, env_parent(env))
    }
}
```

### 7.4 Special Environments

1. package environments
   `library()`, `require()` : attaching packages to search path by setting it as parental environment
   `::` : loading packages to search path
   `base::search()` , `rlang::search_envs()` : search path
2. function environments
   `fn_env()` , `environment()` 로 함수 환경 확인
   함수환경은 함수가 생성된 환경을 뜻함.
   `e$g <- function (x)` 라고 `g()` 의 환경은 `e` 가 아니라 `global environment` 임.

- execution envrionment
  lexical scoping rule 3 'fresh start' 참조

3. namespace
   every package has `package environment` and `namespace environment`

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
****