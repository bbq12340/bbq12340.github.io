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
