/*********************************************
 * OPL 22.1.1.0 Model_2_III
 * Author: Gloria Segurini
 * Creation Date: 12 ott 2023 at 14:34:41
 *********************************************/
 
// INDEXES
int n = ...;
int m = ...; 
int g = ...;
 
range G = 1..g;  // set of days
range G2 = 2..g;// set of days from the second one
range G3 = 3..g; //set of days from the third one
range J = 1..m;  // set of thermal power plants
range I = 1..n; //  set of renewable power plants}

// VARIABLES 
dvar boolean y[G][J];  // Definisci le variabili binarie y[g][j]
dvar float r[G][I]; //variable for renewable energy
dvar float t[G][J]; // variable for thermal energy


//PARAMETERS
float rcv[I] = ...;
float tcv[J] = ...;
float tcf[J] = ...;
float   d[G] = ...;
float c[I][G] = ...;
float    u[J] = ...;
float    l[J] = ...;

 // OBJECTIVE FUNCTION 
minimize 
    sum(g in G, i in I) rcv[i] * r[g, i] +
    sum(g in G, j in J) (tcv[j] * t[g, j] + tcf[j] * y[g, j]);



// CONSTRAINTS
subject to {
   // Vincolo y[g][j] deve essere 0 o 1 per ogni g e j
   forall (g in G, j in J)
      y[g][j] == 0 || y[g][j] == 1;
      
   forall (g in G, i in I)
     r[g,i] >= 0;
     
   forall (g in G, j in J)
     t[g,j] >= 0;
     
   forall (g in G)
     d[g] == sum(i in I) r[g,i] + sum(j in J) t[g,j];
     
     
   forall (g in G, i in I)
     r[g,i] <= c[i,g]; //////NB//////
     
   forall (j in J)
     l[j]*y[1,j] <= t[1,j];
     
   ///8/////
   forall (g in G2, j in J)
     l[j]*(y[g-1,j] + y[g,j] -1) <= t[g,j];
     
    /////9///////
   forall (g in G, j in J)
     t[g,j] <= u[j]*y[g,j];
     
     
   forall (g in G2, j in J)
     t[g,j] <= u[j]*y[g-1,j];
     
   forall (j in J)
     y[1,j] == 1;
     
     
   forall (j in J)
     y[2,j] >= 0;
     
     
   forall (j in J)
     y[2,j] <= 1;
     
   forall (g in G3, j in J)
     y[g,j] >= (y[g-1,j] - y[g-2,j]);
     
     
   forall (g in G3, j in J)
     y[g,j] <= (1 - y[g-2,j] + y[g-1,j]);
     
     ///ADDITIONAL B/////
    sum(g in G, j in J) y[g,j] <= g*m; // THE "=" IN "<=" IS REALLY IMPORTANT
    
     
     
   
   
     
     
    
     
     
    







}
