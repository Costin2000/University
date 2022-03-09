// Copyright 2020
// Authors: Radu Nichita, Matei Simtinică

#ifndef TASK1_H_
#define TASK1_H_

#include "task.h"


/*
 * Task1
 * You have to implement 4 methods:
 * read_problem_data         - read the problem input and store it however you see fit
 * formulate_oracle_question - transform the current problem instance into a SAT instance and write the oracle input
 * decipher_oracle_answer    - transform the SAT answer back to the current problem's answer
 * write_answer              - write the current problem's answer
 */
class Task1 : public Task {
 private:
    // TODO: define necessary variables and/or data structures
    int n,m,k,vertexA, vertexB;
    int v_spies[1000] = {0};
    std::string message;

    struct vertex {
        int value;
        struct vertex *next;
    };

    struct adjaceny_list{
        struct vertex *head;
    };

    struct graph {
        int num_vertexes;
        struct adjaceny_list* vertex_list;
    };

    struct graph* graph;

 public:
    void solve() override {
        read_problem_data();
        formulate_oracle_question();
        ask_oracle();
        decipher_oracle_answer();
        write_answer();
    }

    struct vertex* create_vertex(int value)
    {
        struct vertex* vertex = (struct vertex*) malloc(sizeof(struct vertex));
        vertex -> value = value;
        vertex -> next = NULL;
        return vertex;
    }

    struct graph* create_graph(int size) 
    {
        struct graph* graph = (struct graph*) malloc(sizeof(struct graph));
        graph -> num_vertexes = size;
        graph -> vertex_list = (struct adjaceny_list*) 
        malloc(sizeof(struct adjaceny_list) * (size + 1));

        for(int i = 0; i < size; i++) 
        {
            graph -> vertex_list[i].head = NULL;
        }

        return graph;
    }

    void add_edges(struct graph* graph, int vertexA, int vertexB)
    {
        struct vertex* new_vertex = create_vertex(vertexB);
        new_vertex -> next = graph -> vertex_list[vertexA].head;
        graph -> vertex_list[vertexA].head = new_vertex;

        new_vertex = create_vertex(vertexA);
        new_vertex -> next = graph -> vertex_list[vertexB].head;
        graph -> vertex_list[vertexB].head = new_vertex;

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
        // Store the data in a temporary array
        for(int i = 0; i < m; i++) 
        {
            in>>vertexA;
            in>>vertexB;
            array[idx] = vertexA;
            idx++;
            array[idx] = vertexB;
            idx++;
        }
      
        graph = create_graph(n);

        // Provide the edges extracted fron in_filename to the graph
        for(int i = 0; i < idx; i = i + 2) 
        {
            add_edges(graph, array[i], array[i+1]);
        }
    }

    void formulate_oracle_question() {
        // TODO: transform the current problem into a SAT problem and write it (oracle_in_filename) in a format
        //  understood by the oracle
        
        int variable_matrix[1000][1000];
        int var = 1, number_of_clauses;
        std::ofstream out(oracle_in_filename);
        out<<"p cnf ";
    
        for(int i = 1; i <= n; i++) {

            for(int j = 1; j <= k; j++) {

                variable_matrix[i][j] = var;
                var++;
            }
        }

        // Determine the total number of clauses
        number_of_clauses = (k*(k-1)/2) + 1;
        number_of_clauses *= n;
        number_of_clauses += m*k;

        out<<n*k<<" "<<number_of_clauses<<"\n";

        for(int i = 1; i <= n; i++) {

            // Print the first type of clause, described in the README
            for(int j = 1; j <= k; j++) {

                out<<variable_matrix[i][j]<<" ";
            }

            out<<0<<" ";
            out<<std::endl;

            // Print the second type of clause, described in the README
            int combination[1000], idx = 0;

            for(int j = 1; j <= k; j++) {

                combination[idx] = variable_matrix[i][j];
                idx++;
            }


            printClauses(combination, k, 2, out);

        }


        // Print the third type of clause, described in the README
        for(int i = 1; i <= graph -> num_vertexes; i++) {
                struct vertex* vertex = graph -> vertex_list[i].head;
                
                while(vertex)
                {
                    for(int j = 1; j <= k; j++){
                        out<<-variable_matrix[i][j]<<" "
                        <<-variable_matrix[vertex->value][j]<<" "<<0;

                        out<<std::endl;
                    }


                    vertex = vertex -> next;
                }   
            }
    }

    void decipher_oracle_answer() {
        // TODO: extract the current problem's answer from the answer given by the oracle (oracle_out_filename)

        std::ofstream out(out_filename);

        std::ifstream in(oracle_out_filename);
        int v[1000], nr_of_var, idx = 1;
        in>>message;
        in>>nr_of_var;
        for(int i = 1; i <= nr_of_var; i++)
        {
            in>>v[i];
        }

        for(int i = 1; i <= nr_of_var; i+=k) {

            int i_copy = i;
            int attribution[1000];

            for(int j = 1; j <=k; j++) {

                attribution[j] = v[i];
                i++;
            }

            i = i_copy;

            for(int j = 1; j <=k; j++) {

                if(attribution[j] > 0) {
                    v_spies[idx] = j;
                    idx++;
                }
            }

        } 
    }

    void write_answer() override {
        // TODO: write the answer to the current problem (out_filename)
        
        std::ofstream out(out_filename);
        if(message.compare("True") == 0)
        {
            out<<"True"<<std::endl;
            for(int i = 1; i <= n; i++)
            {
                out<<v_spies[i]<<" ";
            }
        }
        else
        {
            out<<"False";
        }
    }
};

#endif  // TASK1_H_
