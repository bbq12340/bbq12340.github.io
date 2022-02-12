---
layout: post
title: Lecture Note abt. Linear Algebra
---
# Introduction
This note is based on MIT Open Course, [MIT A 2020 Vision Of Linear Algebra](https://www.youtube.com/watch?v=YrHlHbtiSM0&t=106s) taught by Gilbert Strang. This note is written in order to get a better pespective of linear algebra.

# 1 Column Space of Matrix
independent columns in $C$
$$
A = \boldsymbol{CR} = \begin{bmatrix} 
\ & \ 
\end{bmatrix}
\begin{bmatrix} 
\ \\ \ 
\end{bmatrix}
$$
<br></br>
linear combination of columns of A =
$$
A\boldsymbol{x} = \begin{bmatrix} 
1&4&5\\
3&2&5\\
2&1&3    
\end{bmatrix}
\begin{bmatrix} 
x_{1}\\
x_{2}\\
x_{3}
\end{bmatrix} = 
\begin{bmatrix} 
1\\
3\\
2
\end{bmatrix}x_{1}+
\begin{bmatrix} 
4\\
2\\
1
\end{bmatrix}x_2+
\begin{bmatrix} 
5\\
5\\
3
\end{bmatrix}x_3
$$
<br></br>
Column space of A =
$$
\boldsymbol{C}(A) = all \ vectors \ A\boldsymbol{x} = plane \ (in \ this \ case)
$$
column 3 is just a sum of column 1 and column 2 = **Not Indpendent**
<br></br>
$$
A = \bold{CR} = \begin{bmatrix} 
1 & 4\\
3 & 2\\
2 & 1
\end{bmatrix}
\begin{bmatrix} 
1&0&1\\
0&1&1\\
\end{bmatrix}
$$
Row rank = Column rank = $r$ = 2
**Basis** for the column space = $r$ columns of column space
**Basis** for the row space = $r$ columns of row space
<br></br>
**Counting Theorem**
$A\boldsymbol{x}=0$ has one solution $\boldsymbol{x}=(1,1,-1)$
There are $n-r$ independent solutions to $A\boldsymbol{x}=0$
<br></br>
$A = \boldsymbol{CR}$ 
shows followings; (desirable: \+, not:\-)
1. \+ Row rank = Column rank = $r$
2. \+ $C$ has columns directly from $A$
3. \+ $R$ = **row reduced echelon form of A**
4. \- $C$ and $R$ could be very ill-conditioned
5. \- No progress when $A=AI$; such as sqare matrix $A$
# 2 Linear Equations
$A\boldsymbol{x}=0$
$$
A\boldsymbol{x} = \begin{bmatrix}
    row\ 1\\
    .\\
    .\\
    .\\
    row\ m
\end{bmatrix}\begin{bmatrix}
    \ \\
    \ \\
    x \\
    \ \\
    \ 
\end{bmatrix}=\begin{bmatrix}
    0 \\
    . \\
    . \\
    . \\
    0 
\end{bmatrix}
$$
$x$ is orthogonal(=perpendicular) to every row of A
= Every $x$ in the nullspace of A is orthogonal to the row space of A =
$$
N(A)\perp C(A^T) \\
N(A^T)\perp C(A)
$$
= Every $y$ in the nullspace of A is orthogonal to the column space of A
![fundamental subpaces](/images/fund_subspaces.jpeg)
<br></br>
$A=BC$
Columns times row: sum of **blocks** (outer product)
$$
BC = \begin{bmatrix}
    \boldsymbol{b_1}&\boldsymbol{b_2}&...&\boldsymbol{b_n}
\end{bmatrix}\begin{bmatrix}
    \boldsymbol{c_1}\\\boldsymbol{c_2}\\...\\\boldsymbol{c_n}
\end{bmatrix}=b_1c_1+b_2c_2+...+b_nc_n
$$

#### (1) Triangular L and U
$$
A=\begin{bmatrix}
    2&3\\
    4&7
\end{bmatrix}=\begin{bmatrix}
    1&0\\
    2&1
\end{bmatrix}\begin{bmatrix}
    2&3\\
    0&1
\end{bmatrix}=LU
$$
#### (2) Orthogonal Vectors
Vectors
$$x^Ty=0$$
Matrices
$$Q^TQ=I_n=QQ^T$$
$$Q^T=Q^{-1}$$
- Preserved Length $$||Qx||^2=x^TQ^TQx=x^Tx=||x||^2$$
- Eigenvalues $$Qx=\lambda x$$$$||Qx||^2=|\lambda|^2||x||^2$$$$|\lambda|^2=1$$
- Rotation