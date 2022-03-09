// Copyright 2020
// Authors: Radu Nichita, Matei Simtinică

#ifndef TASK2_H_
#define TASK2_H_

#include "task.h"

/*
 * Task2
 * You have to implement 4 methods:
 * read_problem_data         - read the problem input and store it however you see fit
 * formulate_oracle_question - transform the current problem instance into a SAT instance and write the oracle input
 * decipher_oracle_answer    - transform the SAT answer back to the current problem's answer
 * write_answer              - write the current problem's answer
 */
class Task2 : public Task {
 private:
    // TODO: define necessary variables and/or data structures
    int n, m, k, vertexA, vertexB;
    int extended_family[100] = {0};
    int adjacency[1000][1000];
    std::string message;
   
 public:
    void solve() override {
        read_problem_data();
        formulate_oracle_question();
        ask_oracle();
        decipher_oracle_answer();
        write_answer();
    }

    void computeClauses(int array[], int buffer[],  
                    int begin, int end,  
                    int idx, int r, std::ofstream &out) {

        if (idx == r)  
        {  
            for (int j = 0; j < r; j++)  
                out << -buffer[j] << " ";
            out<<0<<" ";  
            out << std::endl;  
            return;  
        }  
      
        for (int i = begin; i <= end &&  
            end - i + 1 >= r - idx; i++) {  
            buffer[idx] = array[i];  
            computeClauses(array, buffer, i+1,  
                            end, idx + 1, r, out);  
        }  
    }

    
    void printClauses(int array[], int n, int r, std::ofstream &out)  
    {  
       
        int buffer[r];  
      
        computeClauses(array, buffer, 0, n-1, 0, r, out);  
    }  

    void read_problem_data() override {
        // TODO: read the problem input (in_filename) and store the data in the object's attributes

        std::ifstream in(in_filename);
        in>>n>>m>>k;
        int array[1000], idx = 0;
        for(int i = 0; i < m; i++) 
        {
            in>>vertexA;
            in>>vertexB;
            array[idx] = vertexA;
            idx++;
            array[idx] = vertexB;
            idx++;
        }
      
        for(int i = 0; i < idx; i = i + 2) 
        {
            adjacency[array[i]][array[i+1]] = adjacency[array[i+1]][array[i]] = 1;
        }
    }

    void formulate_oracle_question() {
        // TODO: transform the current problem into a SAT problem and write it (oracle_in_filename) in a format
        //  understood by the oracle

        int variable_matrix[1000][1000];
        int var = 1;
        std::ofstream out(oracle_in_filename);
        out<<"p cnf ";
        
        for(int i = 1; i <= n; i++) {

            for(int j = 1; j <= k; j++) {

                variable_matrix[i][j] = var;
                var++;
            }
        }

        // Determine the total number of clauses
        int numberOfclauses;
        int numberOfclauses1 = k;
        int numberOfclauses2 = (n * (n - 1) / 2 - m) * (k - 1) * k; 
        int numberOfclauses3 = n * (k * (k - 1)) / 2; 
        int numberOfclauses4 = k * (n * (n - 1)) / 2;

        numberOfclauses = numberOfclauses1 + numberOfclauses2 
        + numberOfclauses3 + numberOfclauses4;

        out<<n*k<<" "<<numberOfclauses<<"\n";

        // Print the first type of clause, described in the README
        for(int i = 1; i <= k; i++) {

            for(int j = 1; j <= n; j++) {

                out<<variable_matrix[j][i]<<" ";
            }

            out<<0<<" ";
            out<<std::endl; 
        }

        for(int i = 1; i <= n; i++) {

            int combination[1000], idx = 0;

            for(int j = 1; j <= k; j++) {

                combination[idx] = variable_matrix[i][j];
                idx++;
            }

            // Print the second type of clause, described in the README
            printClauses(combination, k, 2, out);

            for(int j = 1; j <= n; j++) {

                if(adjacency[i][j] == 1 && i < j) {

                    for(int l = 1; l <= k; l++) {
                        out<<-variable_matrix[i][l]<<" "<<-variable_matrix[j][l]<<" "<<0;
                        out<<std::endl;
                    }
                }
            }

            // Print the third type of clause, described in the README
            for(int j = 1; j <= n; j++) {

                if(adjacency[i][j] == 0 && i < j) {

                    for(int l = 1; l <= k; l++) {

                        for(int o = 1; o <= k; o++){
                            out<<-variable_matrix[i][o]<<" "<<-variable_matrix[j][l]<<" "<<0;
                            out<<std::endl;
                        }
                    }
                }
            }

        }    
    }

    void decipher_oracle_answer() {
        // TODO: extract the current problem's answer from the answer given by the oracle (oracle_out_filename)

        std::ifstream in(oracle_out_filename);
        int array[1000], nr_of_var, current_family = 1, idx = 1;
        in>>message;
        in>>nr_of_var;
        for(int i = 1; i <= nr_of_var; i++)
        {
            in>>array[i];
        }

        for(int i = 1; i <= nr_of_var; i+=k) {

            int i_copy = i;
            int attribution[1000];

            for(int j = 1; j <=k; j++) {

                attribution[j] = array[i];
                i++;
            }

            i = i_copy;

            for(int j = 1; j <=k; j++) {

                if(attribution[j] > 0) {

                    extended_family[idx] = current_family;
                    idx++;
                    
                }
            }
            current_family++;
        }
    }

    void write_answer() override {
        // TODO: write the answer to the current problem (out_filename)

        std::ofstream out(out_filename);
        if(message.compare("True") == 0)
        {
            out<<"True"<<std::endl;
            for(int i = 1; i <= k; i++)
            {
                out<<extended_family[i]<<" ";
            }
        }
        else
        {
            out<<"False";
        }
    }
};

#endif  // TASK2_H_
