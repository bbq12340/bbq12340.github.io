---
layout: post
title: Review on Fundamental Statistics
usemathjax: true
---
# Introduction
This note is based on some basic textbooks and articles that I have been studying over for the past 4 years. It is a review of the fundamental statistics in order to remind myself everytime when I'm confused with it. Some of the mathematical expressions are referred from [here](https://www.cut-the-knot.org/probability.shtml).  


# Contents
1. The Fundamentals
    - Statistics
    - Probability
    - Random Variables
2. Descriptive Statistics
3. Inferential Statistics
4. Applied Statistics


# 1 The Fundamentals
## Statistics
Statistics: A study to easily manage information and aid choice-decision  
Statistics is applied in the following procedure; **Decision problem -> Experiment design -> Collect data -> Clean data -> Explanatory data analysis -> Conclusion**  

Every step of the process has various ways to conduct and even the conclusion can lead you to further procedures such as modeling, model testing, model deploying etc. I hope I can cover every steps throughout the future posts.  

## Probability
**Statistical experiment** allow us to examine a specific situation in controlled condition. When we are trying to calculate the likelihood of a single event to happen in the situation *probability* is ideal for this process. *Sample space*($$\Omega$$) is a collection of all possible outcomes in an experiment.  
Probability: A real-valued function to express the possibility of an event from 0 to 1  

$$
\begin{aligned}
    P: \Omega \to [0,1]
\end{aligned}
$$
#### Independent Event
If, $P(B|A)=P(B)$, A and B are independent to each other. And by *multiplication law*, $P(A\cap B)=P(A)P(B)$
#### Bayes Theorem
When sample space $S=A_1\cup A_2 ...\cup A_n$ while $A_1\cap A_2 ...\cap A_n=\emptyset$ and given case $X, P(X)>0$, the **prior probability** of $A_k$,
$$
P(A_k|X)=\frac{P(A_k\cap X)}{P(X)} \\
=\frac{P(A_k\cap X)}{P(A_1)P(X|A_1)+P(A_n)P(X|A_n)+...+P(A_n)P(X|A_n)}
$$
We will come back to these two deeper in some future.
## Random Variables & Probability Distribution Function
#### Random Variables
It is very neat to express an event with specific number. However, what does $A$ in $P(A)$ indicate? 
$$
P(A) = probability\ of\ event\ A
$$
Let us say we are conducting an experiment where we toss coins 5 times. The sample space would be,
$$
\Omega: \{TTTTT,TTTTH,TTTHH,TTHHH,THHHH,HHHHH\}
$$
If we set the event A as 'the frequency of head in 5 coin tosses', possible outcomes would be $\{0,1,2,3,4,5\}$ and we define this kind of numbers as *random variables*. This is very important difference between mathematics and statistics. Variables in former field has sigular value whereas the latter has different or univariate probability for each potential values.
Thus, **random variables is a real-valued function defined on a sample space**.
$$
X: \Omega \to \R
$$
However, unlike the coin toss experiment there are events where we can't count;*discrete*. This is when the sample space is *continuous*, such as measuring time. In other words, when the possible outcomes of an event can only be expressed through ranges.
#### Probability Distribution Function
This leads us to the next step. What if we need to calculate algebra with the random variables? There are certainly situation when we want to know what $P(B|A)$ is. How should we express the probability of every possible outcome of event A; *probability distribution function*? 
$$
P(A=x)=f_A(x)\ for\ x \in A
$$
Let $X=\{x_1,...,x_n\}$ with the probability $p_k=f_X(x_k)$ and since,
$$
average=\Sigma kp_k=\Sigma x_kf_X(x_k)\\
=mathematical\ expectation=E(X)
$$
Just like the arithmatic average, the variance would be,
$$
V(X)=\Sigma (x_k-E(X))^2f_X(x_k)=\Sigma x_k^2f_X(x_k)-(E(X))^2
$$
and we can further prove,
$$
E(aX+b)=aE(X)+b\\
V(aX+b)=a^2V(X)
$$