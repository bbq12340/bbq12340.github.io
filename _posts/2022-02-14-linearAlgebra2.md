---
layout: post
title: 'Linear Algebra pt. 2'
usemathjax: true
---  
  
#  Introduction
  
The note is based on the lecture, [Matrix Methods in Data Analysis, Signal Processing and Machine Learning](https://www.youtube.com/watch?v=Cx5Z-OslNWE&list=PLUl4u3cNGP63oMNUHXqIUcrkS2PivhN3k ) taught by Gilbert Strang, M.I.T. The note is continued from the previous post about ['Linear Algebra pt. 1'](https://bbq12340.github.io/linearAlgebra1/)The class material is [here](https://math.mit.edu/~gs/learningfromdata/ ). This note is to get a more clear idea about linear algebra and its understanding.  

  
#  Matrix-vector multiplication using Column Space of A
  
###  Column Space
  
When we face <img src="https://latex.codecogs.com/gif.latex?A&#x5C;boldsymbol{x}=&#x5C;boldsymbol{b}"/> where <img src="https://latex.codecogs.com/gif.latex?&#x5C;boldsymbol{b}"/> is non-zero, we've been calculating the multiplication by row times column; dot product. However, it seems very useful when we think vector-wise; column times row.  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?&#x5C;begin{align*}%20%20%20%20given,&#x5C;%20&#x5C;boldsymbol{x}&#x5C;in&#x5C;boldsymbol{R}^3&#x5C;end{align*}"/></p>  
  
<p align="center"><img src="https://latex.codecogs.com/gif.latex?A&#x5C;boldsymbol{x}=&#x5C;begin{bmatrix}2&amp;1&amp;3&#x5C;&#x5C;%20%20%20%203&amp;1&amp;4&#x5C;&#x5C;5&amp;7&amp;12&#x5C;end{bmatrix}&#x5C;begin{bmatrix}x_1&#x5C;&#x5C;%20%20%20%20x_2&#x5C;&#x5C;x_3&#x5C;end{bmatrix}=&#x5C;begin{bmatrix}%20%20%20%202&#x5C;&#x5C;3&#x5C;&#x5C;5&#x5C;end{bmatrix}x_1+&#x5C;begin{bmatrix}%20%20%20%201&#x5C;&#x5C;1&#x5C;&#x5C;7&#x5C;end{bmatrix}x_2+&#x5C;begin{bmatrix}%20%20%20%203&#x5C;&#x5C;4&#x5C;&#x5C;12&#x5C;end{bmatrix}x_3"/></p>  
  
<p align="center"><img src="https://latex.codecogs.com/gif.latex?=combinations&#x5C;%20of&#x5C;%20columns&#x5C;%20of&#x5C;%20A"/></p>  
  
When we think of all possible <img src="https://latex.codecogs.com/gif.latex?A&#x5C;boldsymbol{x}=&#x5C;boldsymbol{b}"/>,  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?all&#x5C;%20combinations&#x5C;%20of&#x5C;%20columns&#x5C;%20of&#x5C;%20A"/></p>  
  
and let us denote this as,  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?=%20C(A)%20=%20Column&#x5C;%20Space&#x5C;%20of&#x5C;%20A"/></p>  
  
in this case, the column space of A would be a plane since the <img src="https://latex.codecogs.com/gif.latex?rank(A)=2"/> which is a plane, a subspace of <img src="https://latex.codecogs.com/gif.latex?&#x5C;boldsymbol{R}^3"/>.  

Thus, **The combinations of columns fills out the column space.**
+ Why is this important?  
  
  When A is too big, and x=rand(m,1). We can sample 100 random x to have a broad idea about the columns of A.  

+ Is <img src="https://latex.codecogs.com/gif.latex?ABC&#x5C;boldsymbol{x}"/> columns of A?  
  yes. <img src="https://latex.codecogs.com/gif.latex?A(BC)&#x5C;boldsymbol{x}"/>
  
###  Rank Theorem; rank(col)=rank(row)
  
We can factor A easily by  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?A%20=%20CR%20&#x5C;&#x5C;C:basis&#x5C;%20of&#x5C;%20the&#x5C;%20column&#x5C;%20space%20&#x5C;&#x5C;"/></p>  
  
Since the dimension of column space of A and C is the same; rank = the number of independent columns,  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?column&#x5C;%20rank%20=%20dim&#x5C;%20of&#x5C;%20column&#x5C;%20space%20=%20rank(A)%20&#x5C;&#x5C;row&#x5C;%20space%20=%20all&#x5C;%20combination&#x5C;%20of&#x5C;%20rows%20=%20column&#x5C;%20space&#x5C;%20of&#x5C;%20A^T%20=%20C(A^T)%20&#x5C;&#x5C;row&#x5C;%20rank%20=%20dim&#x5C;%20of&#x5C;%20row&#x5C;%20space=rank(A^T)%20&#x5C;&#x5C;column&#x5C;%20rank=row&#x5C;%20rank=r"/></p>  
  
Thus, **The number of independent columns equals to the number of independent rows.**  

+ Why is this important?  
  
  When A is 50x100 matrix, we know that the number of independent columns are equal or lower than 50.
+ What is matrix R?  
  
  <img src="https://latex.codecogs.com/gif.latex?R%20=%20row&#x5C;%20reduced&#x5C;%20echelon&#x5C;%20form&#x5C;%20of&#x5C;%20A"/>
  
###  Counting Theorem; dim(col sp.) + dim(null sp.) = # of cols
  
From above, we now know that  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?number&#x5C;%20of&#x5C;%20independent&#x5C;%20solutions&#x5C;%20for&#x5C;%20A&#x5C;boldsymbol{x}=&#x5C;boldsymbol{b}&#x5C;&#x5C;=%20dim&#x5C;%20of&#x5C;%20column&#x5C;%20space&#x5C;&#x5C;=%20rank(A)%20=%20r"/></p>  
  
let us not forget that A is m x n matrix and <img src="https://latex.codecogs.com/gif.latex?&#x5C;boldsymbol{x}&#x5C;in&#x5C;boldsymbol{R}^n"/>. Besides column space, there is null space; all independent solutions to <img src="https://latex.codecogs.com/gif.latex?A&#x5C;boldsymbol{x}=&#x5C;bold{0}"/>. So, since there are <img src="https://latex.codecogs.com/gif.latex?n"/> independent solutions in total,   

<p align="center"><img src="https://latex.codecogs.com/gif.latex?number&#x5C;%20of&#x5C;%20independent&#x5C;%20solutions&#x5C;%20for&#x5C;%20A&#x5C;boldsymbol{x}=&#x5C;bold{0}&#x5C;&#x5C;=%20n-r%20&#x5C;&#x5C;=%20dim&#x5C;%20of&#x5C;%20null&#x5C;%20space"/></p>  
  
And since, null space is orthogonal to row space of A,  
  
We can then organize this thought just like below,  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?Column&#x5C;%20Space:%20C(A)&#x5C;&#x5C;Row&#x5C;%20Space:%20C(A^T)&#x5C;&#x5C;Null&#x5C;%20Space:%20N(A)&#x5C;&#x5C;Null&#x5C;%20Space&#x5C;%20of&#x5C;%20A^T:%20N(A^T)"/></p>  
  
![4 fund subspaces](../images/fund_subspaces.jpeg )
Thus, these are called, **the 4 Fundamental Subspaces**.  

  
We can also expand this vector-wise i.e. outerproduct perspective to the next step.  

#  Matrix-Matrix Multiplication
  
###  Outer Product Approach
  
<p align="center"><img src="https://latex.codecogs.com/gif.latex?A_{m&#x5C;times%20n}%20B_{n&#x5C;times%20p}%20=%20&#x5C;begin{bmatrix}%20%20%20%20col_1&amp;...&amp;col_n&#x5C;end{bmatrix}&#x5C;begin{bmatrix}%20%20%20%20row_1&#x5C;&#x5C;...&#x5C;&#x5C;row_m&#x5C;end{bmatrix}=sum&#x5C;%20of&#x5C;%20(col_k^A)&#x5C;times(row_k^B)&#x5C;&#x5C;&#x5C;&#x5C;"/></p>  
  
Don't forget that the rank of each of columns and rows is 1. So,  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?AB%20=%20sum&#x5C;%20of&#x5C;%20rank&#x5C;%201&#x5C;%20blocks"/></p>  
  
I used blocks to express matrices just so to have a clearer picture. Coming back to the simple factorization using column space is also,  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?A%20=%20CR%20=%20sum&#x5C;%20of&#x5C;%20(ind.&#x5C;%20col_k&#x5C;%20of&#x5C;%20A)&#x5C;times(row_k&#x5C;%20of&#x5C;%20R)&#x5C;&#x5C;=%20sum&#x5C;%20of&#x5C;%20rank&#x5C;%201&#x5C;%20blocks"/></p>  
  
So, unlike dot product (inner product) where we have to calculate the whole matrix, outer produc approach allows us to see the matrix in broad idea with less calculation. We will see how useful it is by looking over to the next key step.  

  
#  The Five Key Factorization
  
1. Elimination <img src="https://latex.codecogs.com/gif.latex?A=LU"/>
2. Gram-Schmidt <img src="https://latex.codecogs.com/gif.latex?A=QR"/>
3. Spectural Theorem <img src="https://latex.codecogs.com/gif.latex?S=Q&#x5C;Lambda%20Q^T"/>
4. <img src="https://latex.codecogs.com/gif.latex?A=X&#x5C;Lambda%20X^T"/>
5. SVD <img src="https://latex.codecogs.com/gif.latex?A=U&#x5C;Sigma%20V^T"/>
  
Calculation with matrices is a difficult job. Factorization makes it so much easier. All factorizations will be explained hopefully.  

  
###  Elimination
  
<p align="center"><img src="https://latex.codecogs.com/gif.latex?A%20=%20LU%20=&#x5C;begin{bmatrix}%20%20%20%201&amp;&amp;&amp;0&#x5C;&#x5C;&amp;.&amp;&amp;&#x5C;&#x5C;&amp;&amp;.&amp;&#x5C;&#x5C;&amp;&amp;&amp;1&#x5C;end{bmatrix}&#x5C;begin{bmatrix}%20%20%20%201&amp;&amp;&amp;&#x5C;&#x5C;&amp;.&amp;&amp;&#x5C;&#x5C;&amp;&amp;.&amp;&#x5C;&#x5C;0&amp;&amp;&amp;1&#x5C;end{bmatrix}"/></p>  
  
In outer product perspective the equation above would be,  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?A%20=%20sum&#x5C;%20of&#x5C;%20(col_k^L)&#x5C;times(row_k^U)"/></p>  
  
This would have a result like below,  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?A%20=%20col_1&#x5C;times%20row_1%20+%20&#x5C;begin{bmatrix}%20%20%20%200&amp;.&amp;.&amp;.&amp;0&#x5C;&#x5C;%20.&#x5C;&#x5C;%20.&amp;&amp;A_2&#x5C;&#x5C;%20.&#x5C;&#x5C;0&#x5C;end{bmatrix}=col_1&#x5C;times%20row_1%20+%20col_2&#x5C;times%20row_2%20+%20&#x5C;begin{bmatrix}%20%20%20%200&amp;.&amp;.&amp;.&amp;0&#x5C;&#x5C;%20.&amp;0&#x5C;&#x5C;%20.&amp;&amp;A_3&#x5C;&#x5C;%20.&#x5C;&#x5C;0&#x5C;end{bmatrix}"/></p>  
  
+ Why do we need this?  

  When we are able to factor a matrix into multiplication of triangular matrices, it makes our equation a lot more lighter such as for inversion and determinant.  

+ How to factorize?  
  
  Suppose there is 2 by 2 matrix, A that can be transformed into an upper triangular matrix U which will have 0 in (2,1). The process would look like this.  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?E_{21}A%20=%20U&#x5C;&#x5C;%20&#x5C;%20&#x5C;&#x5C;E_{21}&#x5C;begin{bmatrix}%20%20%20%204&amp;3&#x5C;&#x5C;8&amp;7&#x5C;end{bmatrix}=&#x5C;begin{bmatrix}%20%20%20%204&amp;3&#x5C;&#x5C;0&amp;1&#x5C;end{bmatrix}&#x5C;&#x5C;&#x5C;%20&#x5C;&#x5C;&#x5C;leftrightarrow%20A=E_{21}^{-1}U&#x5C;&#x5C;&#x5C;leftrightarrow%20A=LU"/></p>  
  
###  Orthonormal & Eigenvalues & Eigenvectors
  
However, there is something further more special than LU decomposition (factorization). Elimination provides us more efficient way to calculate and observe a single matrix equation such as inverse or determinant. We need more than that.  

####  Orthonormal
  
Let us say there is an **orthogonal matrix** Q; square and orthonormal columns.  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?Q=&#x5C;begin{bmatrix}%20%20%20%20q_1&amp;...&amp;q_n&#x5C;end{bmatrix}&#x5C;&#x5C;&#x5C;%20&#x5C;&#x5C;Q^TQ=I=QQ^T"/></p>  
  
This matrix is very special because  

1. length of linearly transformed vector is consistent  
   
   <p align="center"><img src="https://latex.codecogs.com/gif.latex?||Q&#x5C;boldsymbol{x}||=||&#x5C;boldsymbol{x}||"/></p>  
  
2. inverse = transpose  
   
   <p align="center"><img src="https://latex.codecogs.com/gif.latex?Q^T%20=%20Q^{-1}"/></p>  
  
   don't forget that this doesn't apply to every **orthonormal matrices**, only **orthogonal matrices**.  

Since these matrices are very useful tools to manipulate equations, it would be very nice if we could make them and there are few representative methods. It would be wonderful to be able to explain all the methods, but most of them are very well explained in wikipedia. The main focus here is the last one; via eigenvectors.  

1. Rotation matrices  
   
   <p align="center"><img src="https://latex.codecogs.com/gif.latex?Q=%20%20%20&#x5C;begin{bmatrix}%20%20%20%20%20%20%20cos&#x5C;theta&amp;-sin&#x5C;theta%20&#x5C;&#x5C;%20sin&#x5C;theta&amp;cos&#x5C;theta%20%20%20&#x5C;end{bmatrix}"/></p>  
  
2. Reflection matrices  
   
   <p align="center"><img src="https://latex.codecogs.com/gif.latex?Q=%20%20%20%20&#x5C;begin{bmatrix}%20%20%20%20%20%20%20cos&#x5C;theta&amp;sin&#x5C;theta%20&#x5C;&#x5C;%20sin&#x5C;theta&amp;cos&#x5C;theta%20%20%20&#x5C;end{bmatrix}"/></p>  
  
3. Householder reflection  
   
   <p align="center"><img src="https://latex.codecogs.com/gif.latex?H=I-2uu^T"/></p>  
  
4. Hadamard  
   
   Always possible if <img src="https://latex.codecogs.com/gif.latex?&#x5C;frac{N}{4}"/>= whole number 
   <p align="center"><img src="https://latex.codecogs.com/gif.latex?H_2=&#x5C;frac{1}{&#x5C;sqrt{2}}&#x5C;begin{bmatrix}%20%20%20%20%20%20%201&amp;1&#x5C;&#x5C;1&amp;-1%20%20%20&#x5C;end{bmatrix}"/></p>  
  
5. Wavelets  
   
   Haar matrix by scaling  

   <p align="center"><img src="https://latex.codecogs.com/gif.latex?&#x5C;begin{bmatrix}%20%20%20%20%20%20%201&amp;1&amp;1&amp;0&#x5C;&#x5C;1&amp;1&amp;-1&amp;0&#x5C;&#x5C;1&amp;-1&amp;0&amp;1&#x5C;&#x5C;1&amp;-1&amp;0&amp;-1&#x5C;&#x5C;%20%20%20&#x5C;end{bmatrix}_{unit%20.}"/></p>  
  
6. **Eigenvectors**  
   
   We can create as many orthogonal matrices just like above, however, the most useful ones come from **the eigenvector matrices of symmatric / orthogonal matrices**.  

####  Eigenvalues & Eigenvectors
  
Let us say there is a **normal nxn matrix A** that have non-zero eigenvalues.  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?A&#x5C;boldsymbol{x}%20=%20&#x5C;lambda&#x5C;boldsymbol{x}"/></p>  
  
This means that there are some vectors <img src="https://latex.codecogs.com/gif.latex?x"/> with a constant direction after the linear mapping; <img src="https://latex.codecogs.com/gif.latex?T(&#x5C;boldsymbol{x})"/>. Such vectors of A is when dealing with equations like below.  

<p align="center"><img src="https://latex.codecogs.com/gif.latex?v%20=%20c_1x_1+...+c_nx_n&#x5C;&#x5C;A^kv=&#x5C;lambda_1^kc_1x_1+...+&#x5C;lambda_n^kc_nx_n"/></p>  
  
Then, let us say there is a **similar matrix B** that has same eigenvalues as A does.  

$$
B = M^{-1}AM
$$
  
This equation tells us that the similar matrix B has same eigenvalue but the eigenvector is different from A's; <img src="https://latex.codecogs.com/gif.latex?&#x5C;boldsymbol{y}"/>.  
Bonus: There are also some other ways to check when it comes to eigenvalues.  

$$
\begin{aligned}
   \Sigma\lambda &= tr(A) \\
   \Pi\lambda &= det(A)
\end{aligned}
$$
  
Let us say there is a **symmetric nxn matrix S** that have non-zero eigenvalues. Something we to remember is that the eigenvalues are real numbers and the eigenvectors are orthogonal.  

$$
\begin{aligned}
   S=\begin{bmatrix}
      0&1\\1&0
   \end{bmatrix}\\
   \ \\
   M^{-1}SM = \Lambda = \begin{bmatrix}
      1&0\\0&-1
   \end{bmatrix}\\
   \ \\
   SM = M\Lambda
\end{aligned}
$$
  
Implementing all we have learnt above in the current chapter, we are able to understand following; **S is similar to <img src="https://latex.codecogs.com/gif.latex?&#x5C;Lambda"/> and <img src="https://latex.codecogs.com/gif.latex?M"/> is eigenvector matrix**. Now, with some further thinking, this does not only work in symmetric but also normal matrices. Thus, we can organize everything into two simple factorizations.  

$$
\begin{aligned}
   A &= X^{-1}\Lambda X \\
   S &= Q^{-1}\Lambda Q
\end{aligned}
$$
  
+ In conclusion?
  We can factor any matrices into composition of eigenvalues & eigenvectors. In addition, symmetric matrices provide us very useful orthogonal matrices.
  