# chapter 2
library(lobstr)

# 2.2 binding basics
# 1. names vs values
# names = symbol = reference , values = object
x <- c(1,2,3) 
y <- x
obj_addr(x)
obj_addr(y)
# 2. binding
# '<-' = bind / refer / point to
# 3. name 에 룰이 존재
# `` 사용시 룰 깰 수 있음

# 2.3 copy-on-modify
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

# 2.4 Object Size
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

# 2.5 Modify-in-place
# 1. exceptions to copy-on-modify
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


# chapter 3
# 3.2 atomic vectors
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

# 3.3 attributes
# 1. attributes
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
# 2. names
x <- c(a=1,b=2,c=3)
x <- 1:3
names(x) <- c("a","b","c")
names(x)
x <- setNames(1:3, c("a","b")) # names NULL 이 아닌 NA
x <- unname(x)
# 3. dimensions
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

# 3.4 S3 atomic vectors

# factor: built on top of integer vectors with attributes 'class=factor', 'levels='
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

# Dates: built on top of double vectors with attributes 'class=Date'
today <- Sys.Date(); today 
typeof(today)
attributes(today)
unclass(today)

# Date-times: built on top of atomic (double) vector with attributes 'class=POSIXct', 'tzone='
now_ct <- as.POSIXct("2018-08-01 22:00", tz="UTC"); now_ct
typeof(now_ct)
attributes(now_ct)
attributes(structure(now_ct, tzone="Asia/Tokyo"))

# Durations: built on top of doubles with attribtues 'class=difftime' , 'units='
one_week_1 <- as.difftime(1, units="weeks"); one_week_1
typeof(one_week_1)
attributes(one_week_1)

# 3.5 Lists
# lists
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
# testing & coercion
typeof(list()); is.list(); as.list(); unlist();
as.vector() # list 도 벡이므로 atomic vector 로 바꾸려면,
typeof(as.vector(unlist(list(1:3))))
# matrices & arrays
dim(l1) <- c(2,2)
attributes(l1); str(l1); l1
l1[[2,2]]
dim(l1) <- c(1,2,2)

# 3.6 Data frames and tibbles
# data frames: built on top of lists with attributes 'name', 'class', 'row.names'
df1 <- data.frame(x=1:3, y=letters[1:3]); df1
typeof(df1); attributes(df1); str(df1)
df1 <- data.frame(x=1:3, y=letters[1:3], stringsAsFactors=FALSE); df1; str(df1)
# tibbles: built on top of lists
library(tibble)
df2 <- tibble(x=1:3, y=letters[1:3]); df2
typeof(df2); attributes(df2); str(df2) # tibble 은 stringsAsFactors 인자가 필요 없다.

# row names
df3 <- data.frame(
    age=c(35,27,18),
    hair=c("blond","brown","black"),
    row.names=c("Bob","Susan","Sam")
)
attributes(df3); str(df3)
rownames(df3) <- c("David","Josh","Ronald"); df3

# list & matrix
df <- data.frame(x=1:3)
df$y <- list(1:2, 1:3, 1:4)
attributes(df); str(df)
df$z <- matrix(1:9, nrow=3); df
attributes(df); str(df)
df$t <- df1
attributes(df); str(df)

# 3.7 NULL
typeof(NULL)
length(NULL)
attributes(NULL)


# chapter 4 Subsetting

# 4.2 multiple elements
# atomic vectors
x <- c(2.1,4.2,3.3,5.4)
x[c(3,1)] # positive vector
x[-c(3,1)] # negative vector
x[c(T,T,F,F)]; x[x>3]; x[c(T, F)]; x[c(T,F,NA)] # logical vector
x[] # nothing returns orginial
x[0] # zero returns zero-length vector
names(x) <- c(letters[1:4]); x[c("d","c")] # named vectors can be subset by character vectors
x[factor("d")] # factors in subset are integer vectors

# lists
l1 <- list(1:3, letters[1:3], c(T,T,F))
typeof(l1[1]); typeof(l1[[1]])
l1[c(1,2)]; l1[[1]]
l1[c(T,F,T)]
l1[]
l1[0]
names(l1) <- c(letters[1:3]); l1[a[2]]

# matrices and arrays
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

# data frame
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

# 4.3 single element
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

# 4.4 subsetting & assignment
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

# 4.5 applications
# lookup: character matching
x <- c("m","f","u","f","f","m","m")
lookup <- c(m="Male", f="Female", u=NA)
lookup[x]; unname(lookup[x])
# matching & merging
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
# sample
mtcars
mtcars[sample(10),] # sample(n, k): random permutation of 1:n then select k
mtcars[sample(10, 4),]
mtcars[sample(10, 4, replace=TRUE),]
# ordering: returns how to order vector in integer vector
x <- c("a","c","b", NA) # default: decreasing & na.last=TRUE
y <- c("b","c","a")
order(x); order(y)
x[order(x)]
# expanding aggregated counts: 데이터프레임 행/열을 여러번 출력할때
df <- data.frame(x=c(2,4,1),y=c(9,11,6),n=c(3,5,1)); df
df[rep(1:nrow(df),df$n),]
df[rep(1:nrow(df),c(3,5,1)),]
# removing columns from dataframe
df$n <- list(NULL); df
df[["n"]] <- NULL; df
# which : returns vector of index which is TRUE
x <- 1:5 >= 4; x; x1 <- which(x); x1
# intersect: intersect() , &
y <- 6:10 >=6; y; y1 <- which(y)
intersect(x1,y1)
x1 & y1
# union: union(), |
x1 | y1
# setdiff: setdiff(), * & !*
x1 & !y1

# chapter 5 control flow

# 5.2 choices
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

# 5.3 loops
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
