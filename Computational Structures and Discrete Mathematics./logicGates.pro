/*
Jorge Aguinaga
CS 2130 
Dr. Huson
Filename: logicGates.pro

This program will simulate a logic circuit
*/

%define AND gate based on its truth table
andgate (0,0,0).
andgate (0,1,0).
andgate (1,0,0).
andgate (1,1,1).

%define NOT gate based on its trith table
notgate (0,0).
notgate (1,0).

%define OR gate based on its truth table
orgate (0,0,0).
orgate (0,1,1).
orgate (1,0,1).
orgate (1,1,1).

%combine your gates to create the circuit
circuit (W,X,Y,Z,F):-( andgate(W,X,T1), notgate(Y,T2), orgate(Y,Z,T3), orgate(X,T2,T4), andgate(T1,T4,T5), notgate(T3,T6), orgate(T5,T6,F)).










