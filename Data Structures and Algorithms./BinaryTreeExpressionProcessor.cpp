
#include <iostream>
#include <string>
#include <stack>
#include <sstream>
#include <cmath>
#include <cstring>
#include <cstdio>

using std::stack;
using std::istringstream;
using std::ostringstream;
using std::string;
using std::cin;
using std::cout;
using std::cerr;
using std::endl;
using std::pow;



struct Node {
	string data{};
	Node* lchild{ nullptr };
	Node* rchild{ nullptr };

};

class TreeParser {
private :
	stack<string> mathStack; 
	double castStrToDouble(string const& s); 
	string castDoubleToStr(const double d); 
	void inOrderTraversal(Node* ptr) const;
	void postOrderTraversal(Node* ptr) const;
	void initialize();
	void clear(Node* ptr);
	Node* root{ nullptr };
 
	void processExpression(Node* p);
	void computeAnswer(Node*p);
protected:
	string expression; 
	int position;
public: 
	~TreeParser();
	TreeParser(); 
	void displayParseTree(); 
	void processExpression(string& expression); 
	void inOrderTraversal() const;
	void postOrderTraversal() const;
	string computeAnswer();
	void clear();




};

TreeParser::~TreeParser() {
	clear(this->root);
}

void TreeParser::clear() {
	clear(this->root);
}

void TreeParser::clear(Node* ptr) {
	if (ptr) {
		clear(ptr->lchild);
		clear(ptr->rchild);
		delete ptr;
	}
}

void TreeParser::initialize() {
	expression = "";
	position = 0;
	while (!mathStack.empty()) {
		mathStack.pop();
	}
}

double TreeParser::castStrToDouble(const string &s) {
	istringstream iss(s);
	double x;
	iss >> x;
	return x;
} 

string TreeParser::castDoubleToStr(const double d) {
	ostringstream oss;
	oss << d;
	return oss.str();

} 

TreeParser::TreeParser() {
	initialize();
}

void TreeParser:: processExpression(string& expression) {

	if (expression.length() != 0) {
		this->expression = expression;
		position = 0;
		Node* temp = new Node;
		root = temp;
		processExpression(root);
	}

}


void TreeParser::processExpression(Node* p) {
	while (position != expression.length()) {
		string tempString = "";
		if (expression[position] == '(') {
			Node* temp = new Node;
			p->lchild = temp;
			position++;
			processExpression(p->lchild);
		}
		else if (expression[position] == '0' || expression[position] == '1' ||
			expression[position] == '2' || expression[position] == '3' || expression[position] == '4' ||
			expression[position] == '5' || expression[position] == '6' || expression[position] == '7' ||
			expression[position] == '8' || expression[position] == '9' || expression[position] == '.') {
			while (expression[position] == '0' || expression[position] == '1' ||
				expression[position] == '2' || expression[position] == '3' || expression[position] == '4' ||
				expression[position] == '5' || expression[position] == '6' || expression[position] == '7' ||
				expression[position] == '8' || expression[position] == '9' || expression[position] == '.')
			{
				tempString += expression[position];
				position++;
			}
			p->data = tempString;
			return;
		}
		else if (expression[position] == '+' || expression[position] == '-' ||
			expression[position] == '*' || expression[position] == '^' || expression[position] == '/') {
			p->data = expression[position];
			Node* temp2 = new Node;
			p->rchild = temp2;
			position++;
			processExpression(p->rchild);
		}
		else if (expression[position] == ')') {
			position++;
			return;
		}
		else if (expression[position] == 32) {
			position++;
		}
		}


	}



void TreeParser::inOrderTraversal() const {
	
	inOrderTraversal(this->root);
}


void TreeParser::inOrderTraversal(Node* ptr) const {
	if (ptr) {
		
		inOrderTraversal(ptr->lchild);
		cout << ptr->data;
		inOrderTraversal(ptr->rchild);
	}
}

void TreeParser::postOrderTraversal() const {
	postOrderTraversal(this->root);
}

void TreeParser::postOrderTraversal(Node* ptr) const {
	if (ptr) {
		postOrderTraversal(ptr->lchild);
		postOrderTraversal(ptr->rchild);
		cout << ptr->data;
	}
}


string TreeParser::computeAnswer() {
	computeAnswer(this->root);
	return mathStack.top();
}

void TreeParser::computeAnswer(Node* p) {
	int pos = 0;
	if (p) {
		computeAnswer(p->lchild);
		computeAnswer(p->rchild);
		if (p->data == "0" || p->data == "1" || p->data == "2" || p->data == "3" ||
			p->data == "4" || p->data == "5" || p->data == "6" || p->data == "7"
			|| p->data == "8" || p->data == "9" ) {
			mathStack.push(p->data);
		}
		else if (p->data[pos] =='0' || p->data[pos] == '1' || p->data[pos] == '3' || 
			p->data[pos] == '4' || p->data[pos] == '5' || p->data[pos] == '6' || 
			p->data[pos] == '7' || p->data[pos] == '8' || p->data[pos] == '9') {
			mathStack.push(p->data);
		}
		else if (p->data == "+" ){
			
			double a = castStrToDouble(mathStack.top());
			mathStack.pop();
			double b = castStrToDouble(mathStack.top());
			mathStack.pop();
			double answer = a + b;
			string temp = castDoubleToStr(answer);
			mathStack.push(temp);

		}
		else if (p->data == "-") {

			double a = castStrToDouble(mathStack.top());
			mathStack.pop();
			double b = castStrToDouble(mathStack.top());
			mathStack.pop();
			double answer = b - a;
			string temp = castDoubleToStr(answer);
			mathStack.push(temp);

		}
		else if (p->data == "/") {

			double a = castStrToDouble(mathStack.top());
			mathStack.pop();
			double b = castStrToDouble(mathStack.top());
			mathStack.pop();
			double answer = b / a;
			string temp = castDoubleToStr(answer);
			mathStack.push(temp);

		}
		else if (p->data == "*") {

			double a = castStrToDouble(mathStack.top());
			mathStack.pop();
			double b = castStrToDouble(mathStack.top());
			mathStack.pop();
			double answer = a * b;
			string temp = castDoubleToStr(answer);
			mathStack.push(temp);

		}
		else if (p->data == "^") {

			double a = castStrToDouble(mathStack.top());
			mathStack.pop();
			double b = castStrToDouble(mathStack.top());
			mathStack.pop();
			double answer = pow(b,a);
			string temp = castDoubleToStr(answer);
			mathStack.push(temp);

		}

	}

}


void TreeParser::displayParseTree() {
	cout << "The expression seen using in-order traversal: "; 
	inOrderTraversal();
	cout << endl;
	cout << "The expression seen using post-order traversal: "; 
	postOrderTraversal();
	cout << endl;
	
}

void pressEnterToContinue() {
	printf("Press Enterto continue\n");

	cin.get();

}

// Copyright 2021, Bradley Peterson, Weber State University, all rights reserved. (07/2021)

int main() {

	TreeParser *tp = new TreeParser;
	
	
	string expression = "(4+7)";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display 11 as a double output
	
	expression = "(7-4)";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display 3 as a double output

  expression = "(9*5)";
  tp->processExpression(expression);
  tp->displayParseTree();
  cout << "The result is: " << tp->computeAnswer() << endl; //Should display 45 as a double output

	expression = "(4^3)";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display 64 as a double output

	expression = "((2-5)-5)";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display -8 as a double output
	
	expression = "(5 * (6/2))";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display 15 as a double output
	
	expression = "((6 / 3) + (8 * 2))";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display 18 as a double output

	expression = "(543+321)";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display 864 as a double output

	expression = "(7.5-3.25)";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display 4.25 as a double output

	expression = "(5 + (34 - (7 * (32 / (16 * 0.5)))))";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display 11 as a double output

  expression = "((5*(3+2))+(7*(4+6)))";
  tp->processExpression(expression);
  tp->displayParseTree();
  cout << "The result is: " << tp->computeAnswer() << endl; //Should display 95 as a double output


	expression = "(((2+3)*4)+(7+(8/2)))";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display 31 as a double output

	expression = "(((((3+12)-7)*120)/(2+3))^3)";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display close to 7077888 as a double output 
                                                            //NOTE, it won't be exact, it will display as scientific notation!
	
	expression = "(((((9+(2*(110-(30/2))))*8)+1000)/2)+(((3^4)+1)/2))";
	tp->processExpression(expression);
	tp->displayParseTree();
	cout << "The result is: " << tp->computeAnswer() << endl; //Should display close to 1337 as a double/decimal output
	
	pressEnterToContinue();
	return 0;
}
