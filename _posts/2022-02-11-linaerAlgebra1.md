---
layout: post
title: 'Linear Algebra pt. 1'
usemathjax: true
---  
# Introduction
The note is based on a [MIT open course](https://www.youtube.com/playlist?list=PLE7DDD91010BC51F8) by professor Gilbert Strang. The note is to alter my perspective on matrices and spaces. Hopefully, at then end of the post, I will have some more insights in linear algebra, an essential subject for statistical algorithms.

# Contents
1. Matrices
2. Spaces

# Matrices
### Intro to Matrices
Let us say there are two linear equations,  

$$
\begin{aligned}
    2x-y&=0\\
    -x+2y&=3\\
    \lrarr\\
    \begin{bmatrix}
        2&-1\\-1&2
    \end{bmatrix}\begin{bmatrix}
        x\\y
    \end{bmatrix}&=\begin{bmatrix}
        0\\3
    \end{bmatrix}
\end{aligned}
$$  

There are several ways to view this and one way would be by *row picture* which would plotting a 2-D plane graph with the top two linear equations (we're quite experienced with this). However, we can also see this by *column picture*.  

$$
\begin{aligned}
    x\begin{bmatrix}
    2\\-1
    \end{bmatrix}+y\begin{bmatrix}
        -1\\2
    \end{bmatrix}&=\begin{bmatrix}
        0\\3
    \end{bmatrix}
\end{aligned}
$$  

This picture can be illustrated into another 2-D plot with vectors. This equation is called the **linear combination of columns** and is often denoted as $$A\boldsymbol{x}=\boldsymbol{b}$$.  

It doesn't seem so different when there are two equations, but when we think of situations with 3 equations, it is a lot more easier to think of a plot with 3 vectors (column picture) than 3 plane collision (row picture).  

Coming back to the 2 equations, can we solve $$A\boldsymbol{x}=\boldsymbol{b}$$ for every $$\boldsymbol{b}$$? The question can be translated into two different perspectives. From the perspective of "row", will there going to be every solution for every $$\boldsymbol{b}$$? From the perspective of "column", do the linear combination of the columns fill 2-D space? If the two columns lie on the same plane, the answer would be no.  

$$
\begin{aligned}
    A=\begin{bmatrix}
        1&-2\\2&-4
    \end{bmatrix}
\end{aligned}
$$  

The column picture allows us to see the linear equations into a combination of vectors which gives us a clear way to observe.  

### Elimination
Let us say there are 3 equations,  

$$
\begin{aligned}
    x+2y+z&=2\\
    3x+8y+z&=12\\
    4y+z&=2\\
    \lrarr\\
    \begin{bmatrix}
        1&2&1\\3&8&1\\0&4&1
    \end{bmatrix}\begin{bmatrix}
        x\\y\\z
    \end{bmatrix}&=\begin{bmatrix}
        2\\12\\2
    \end{bmatrix}
\end{aligned}
$$  

It is really difficult to plot vectors in head once the dimension eleveates. So humans have found out a way to solve linear equations by *elimination*.  

$$
\begin{aligned}
    x+2y+z&=2\\
    3x+8y+z&=12\\
    4y+z&=2\\
    \lrarr\\
    3x+6y+3z&=6\\
    3x+8y+z&=12\\
    4y+z&=2\\
    \lrarr\\
    -2y+2z&=-6\\
    4y+z&=2\\
    \lrarr\\
    z&=-5\\
    y&=\frac{7}{4}\\
    x&=1
\end{aligned}
$$  

This is also possible with the matrix augmenting the b column.  

$$
\begin{aligned}
    [A|\boldsymbol{b}]=\\
    \ \\
    \begin{bmatrix}
        \ldots row1 \ldots\\\ldots row2 \ldots\\\ldots row3 \ldots
    \end{bmatrix}&=\\
    \ \\
    \begin{bmatrix}
        1&2&1&2\\3&8&1&12\\0&4&1&2
    \end{bmatrix}
    \rarr\begin{bmatrix}
        1&2&1&2\\0&2&-2&6\\0&4&1&2
    \end{bmatrix}
    &\rarr\begin{bmatrix}
        1&2&1&2\\0&2&-2&6\\0&0&5&-10
    \end{bmatrix}\\
    \ \\
    =[U\boldsymbol{c}]
\end{aligned}
$$  

The last part is to seperate the matrix and the column and solve $$U\boldsymbol{x}=\boldsymbol{c}$$. However, there must be something more than just arrows when transforming. If we focus on the first arrow, we are executing "subtract 3 row1 from row2" to turn (2,1) element into 0. And since (3,1) element is 0, we skip to the next step where we want to "subtract 2 row2 from row3" to turn (3,2) element into 0.  

$$
\begin{aligned}
    E_{21}A&=\begin{bmatrix}
        \ & r_1 & \ \\ \ & r_2 & \ \\ \ & r_3 & \ \\
    \end{bmatrix}\begin{bmatrix}
        1&2&1\\3&8&1\\0&4&1
    \end{bmatrix}=\begin{bmatrix}
        1&2&1\\0&2&-2\\0&4&1
    \end{bmatrix}\\
    \lrarr\\
    E_{21}&=\begin{bmatrix}
        1&0&0\\-3&1&0\\0&0&1
    \end{bmatrix}
\end{aligned}
$$  

Before trying to understand the mechanism hiding here, we need to understand the **matrix multiplication**.  

#### 4 Types of Matrix Multiplication  
We will skip the dot product (row times column) part because it is a very simple process.  

$$
\begin{aligned}
    AB=C\\
    \lrarr\begin{bmatrix}
        \ & \ & \ \\ c_1 & c_2 & c_3 \\ \ & \ & \ \\
    \end{bmatrix}\begin{bmatrix}
        \ & r_1 & \ \\ \ & r_2 & \ \\ \ & r_3 & \ \\
    \end{bmatrix}\ldots(1)\\
    \begin{bmatrix}
        \ & \ & \ \\ \ & A & \ \\ \ & \ & \ \\
    \end{bmatrix}\begin{bmatrix}
        \ & \ & \ \\ c_1 & c_2 & c_3 \\ \ & \ & \ \\
    \end{bmatrix}\ldots(2)\\
    =\begin{bmatrix}
        \ & r_1 & \ \\ \ & r_2 & \ \\ \ & r_3 & \ \\
    \end{bmatrix}\begin{bmatrix}
        \ & \ & \ \\ \ & B & \ \\ \ & \ & \ \\
    \end{bmatrix}\ldots(3)\\
    =\begin{bmatrix}
        \ & \ & \ \\ \ & C & \ \\ \ & \ & \ \\
    \end{bmatrix}\\
\end{aligned}
$$  

(1) is the outer product (column times row). Each of the multiplication of column and row is a matrix and the sum adds up to become C. (2) illustrates that the columns of C is the combination of columns of B$$A\times col_k^B=col_k^C$$. (3) shows that the row of C is the combination of rows of A $$row_k^A\times B=row_k^C$$. (2) and (3) can be organized as following; column operation for (2), row operation for (3). Implementing this to the previous example, **in order to operate by rows in the right side of the equation, we need to multiply a matrix on the left.** If you can't see it right away, try (3) and (1) in order.  

$$
\begin{aligned}
    \text{(Ex 1)}\\
    E_{21}A&=\begin{bmatrix}
        \ & r_1 & \ \\ \ & r_2 & \ \\ \ & r_3 & \ \\
    \end{bmatrix}\begin{bmatrix}
        1&2&1\\3&8&1\\0&4&1
    \end{bmatrix}=\begin{bmatrix}
        1&2&1\\0&2&-2\\0&4&1
    \end{bmatrix}\\
    \ \\
    r_1A&= first\ row\ of\ A \\
    r_2A&= second\ row\ - 3\ first\ row\ of\ A\\
    r_3A&= third\ row\ of\ A \\
    E_{21}&=\begin{bmatrix}
        1&0&0\\-3&1&0\\0&0&1
    \end{bmatrix}\\
    &E_{32}E_{31}(E_{21}A)=U\\
    &E_{32}E_{31}(E_{21}[A|\boldsymbol{b}])=[U|\boldsymbol{c}]\\
\end{aligned}
$$  

So, if we are trying to operate by columns in the right side of the equation, we need to multiply a matrix on the right. This leads to the answer why the equation below is true.  

$$
\begin{aligned}
    AB \neq BA
\end{aligned}
$$  

In addition, what the E matrices; *elementary matrices* are really doing is just applying multiplication + subtraction between rows. Therefore, we can infer there is some multiplication that would do the operation backwards; *inverse*.  
$$
\begin{aligned}
    U\rarr A\\
    ?U=A
\end{aligned}
$$  

+ Bonus: What if we there are times we need both row and column operation? Is there an order for it?  
  
  No.
  $$
  \begin{aligned}
      E_rBE_c = (E_rB)E_c = E_r(BE_c)
  \end{aligned}
  $$

+ Bonus 2: What if the second pivot is 0 after the E(2,1) progress?  

    $$
    \begin{aligned}
        \begin{bmatrix}
        1&2&1\\3&6&1\\0&4&1
    \end{bmatrix}\rarr\begin{bmatrix}
        1&2&1\\0&0&-2\\0&4&1
    \end{bmatrix}
    \end{aligned}
    $$
    We can exchange the row 2 and 3; *permutation*.
#### Inverse
So, we want a matrix that does exactly backwards what it does. If the matrix does its operation -> do it backwards, it is going to do nothing on the target matrix; *identity matrix*. It returns the exact matrix as you can see by thinking of the three types of multiplication from prior section.  

$$
\begin{aligned}
    I=\begin{bmatrix}
        1&0\\0&1
    \end{bmatrix}
\end{aligned}
$$

So,  

$$
\begin{aligned}
    A^{-1}A &= AA^{-1} = I\\
    \lrarr E[A|I] &=[I|A^{-1}]\\
    \lrarr E&=A^{-1}
\end{aligned}
$$  

Just like the prior section (Ex 1), A is going to be manipulated by E into I. Coming back to the elimination, when we say there is no situation such as 'Bonus2',  

$$
\begin{aligned}
    &E_{32}E_{31}E_{21}A = U\\
    &\lrarr\\
    &A = E_{32}^{-1}E_{31}^{-1}E_{21}^{-1}U=LU
\end{aligned}
$$  

However, there are times when there is no matrix that can be inversible. It is when $$A\boldsymbol{x}=\boldsymbol{0}, \boldsymbol{x} \neq \boldsymbol{0}$$ exist. In other words, when the combination of columns of A can't produce the identity matrix.  

$$
\begin{aligned}
    A=\begin{bmatrix}
        1&3\\2&6
    \end{bmatrix}\\
    A^{-1}A\boldsymbol{x}=\boldsymbol{0}
\end{aligned}
$$  

Additionally, there are some other important points.  

$$
\begin{aligned}
    (AB)(B^{-1}A^{-1})=I\\
    \lrarr (AB)^{-1}=(B^{-1}A^{-1})\\
    (A^{-1})^TA^T=I\\
    \lrarr (A^{-1})^T=(A^T)^{-1}
\end{aligned}
$$  

#### Permutation
There are matrices that can exchange rows. Through with the permutation matrices we are able to improve the process of elimination. Think about the words below.  

$$
\begin{aligned}
    &P = identity\ matrix\ with\ reordered\ rows\\
    &P^{-1}=P^T
\end{aligned}
$$  

Multiplying identity matrix returns the original matrix. If we reorder the rows of an identity matrix, we can exchange rows of the original matrix.  

#### Transpose
Symmetric matrices are extremely useful because we don't have to know about the other side. However, how do we get those symmetric matrices?  

$$
\begin{aligned}
    &S^T=S\\
    &R^TR=R^T(R^T)^T=R^TR
\end{aligned}
$$  

With the knowledge of matrix multiplication we are ready to look at *spaces*.

# Spaces

*updating...*