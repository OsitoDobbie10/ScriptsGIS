# -*- coding: utf-8 -*-
"""
Created on Sun Jan 31 12:23:43 2021

@author: Usuario
"""
import os 
import math 
#linea = "teqc -O.dec 30 +obs diciembre1.o CRNO20201201_000000.AS " 
#variables locales  
c = 'C:/Users/Usuario/Desktop/prueba' #primera opcion de lqa ruta 
c2 = os.getcwd() #seguna opcion de la ruta    
#filtrar archivos .AS
def filtar_as(c):
    archivos_as = [] 
    for ruta,direccion,archivo in os.walk(c):
        for file in archivo:
            if file.endswith('.AS'):
                archivos_as.append(file) 
    return archivos_as   
lista_as = filtar_as(c)  
#convertir archivos .AS a .c  
         
def convertir_as_o(lista_as) :  
        for AS in lista_as:   
            new_name = AS.split('.')[0] + '.o '
            out_name = "teqc -O.dec 30 +obs " + new_name +  AS
            print(out_name)
            #os.system(out_name)    
convertir_as_o(lista_as)   

#obtener coordenadas de los archivos 
def buscar_o(c):
    archivos_as = [] 
    for ruta,direccion,archivo in os.walk(c):
        for file in archivo:
            if file.endswith('.o'):
                archivos_as.append(file) 
    return archivos_as   
f = len(buscar_o(c))
#print(f)
lista1 = buscar_o(c)[0] 
lista2 = buscar_o(c)[1] 
lista3 = buscar_o(c)[3]
lista4 = buscar_o(c)[4]
lista5 = buscar_o(c)[5]
lista6 = buscar_o(c)[6]
lista7 = buscar_o(c)[7]
lista8 = buscar_o(c)[8]
lista9 = buscar_o(c)[9]
lista10 = buscar_o(c)[10] 
lista11 = buscar_o(c)[11]
lista12 = buscar_o(c)[12]
lista13 = buscar_o(c)[13]
lista14 = buscar_o(c)[14]
lista15 = buscar_o(c)[15] 
lista16 = buscar_o(c)[16]
lista17 = buscar_o(c)[17]
lista18 = buscar_o(c)[18]
lista19 = buscar_o(c)[19]
lista20 = buscar_o(c)[20]
lista21 = buscar_o(c)[21]
lista22 = buscar_o(c)[22]
lista23 = buscar_o(c)[23]
lista24 = buscar_o(c)[24]
lista25 = buscar_o(c)[25]
lista26 = buscar_o(c)[26]
lista27 = buscar_o(c)[27]
lista28 = buscar_o(c)[28] 
lista29 = buscar_o(c)[29] 
lista30 = buscar_o(c)[30] 
def filtrar_coordenadas(lista):
    with open(lista) as ls:
        linea = ls.readlines()[9:10]
        for line in linea:
            print()
            x = line.strip().split(" ")[0]
            y = line.strip().split(" ")[1] 
            z = line.strip().split(" ")[3] 
    return [x,y,z]           
filtrar_coordenadas(lista1)  
x_list1 = filtrar_coordenadas(lista1)[0]
y_list1 = filtrar_coordenadas(lista1)[1] 
z_list1 = filtrar_coordenadas(lista1)[2]    
x_list2 = filtrar_coordenadas(lista2)[0]
y_list2 = filtrar_coordenadas(lista2)[1] 
z_list2 = filtrar_coordenadas(lista2)[2]  
x_list3 = filtrar_coordenadas(lista3)[0]
y_list3 = filtrar_coordenadas(lista3)[1] 
z_list3 = filtrar_coordenadas(lista3)[2]  
x_list4 = filtrar_coordenadas(lista4)[0]
y_list4 = filtrar_coordenadas(lista4)[1] 
z_list4 = filtrar_coordenadas(lista4)[2] 
x_list5 = filtrar_coordenadas(lista5)[0]
y_list5 = filtrar_coordenadas(lista5)[1] 
z_list5 = filtrar_coordenadas(lista5)[2] 
x_list6 = filtrar_coordenadas(lista6)[0]
y_list6 = filtrar_coordenadas(lista6)[1] 
z_list6 = filtrar_coordenadas(lista6)[2] 
x_list7 = filtrar_coordenadas(lista7)[0]
y_list7 = filtrar_coordenadas(lista7)[1] 
z_list7 = filtrar_coordenadas(lista7)[2] 
x_list8 = filtrar_coordenadas(lista8)[0]
y_list8 = filtrar_coordenadas(lista8)[1] 
z_list8 = filtrar_coordenadas(lista8)[2] 
x_list9 = filtrar_coordenadas(lista9)[0]
y_list9 = filtrar_coordenadas(lista9)[1] 
z_list9 = filtrar_coordenadas(lista9)[2] 
x_list10 = filtrar_coordenadas(lista10)[0]
y_list10 = filtrar_coordenadas(lista10)[1] 
z_list10 = filtrar_coordenadas(lista10)[2] 
x_list11 = filtrar_coordenadas(lista11)[0]
y_list11 = filtrar_coordenadas(lista11)[1] 
z_list11 = filtrar_coordenadas(lista11)[2] 
x_list12 = filtrar_coordenadas(lista12)[0]
y_list12 = filtrar_coordenadas(lista12)[1] 
z_list12 = filtrar_coordenadas(lista12)[2] 
x_list13 = filtrar_coordenadas(lista13)[0]
y_list13 = filtrar_coordenadas(lista13)[1] 
z_list13 = filtrar_coordenadas(lista13)[2] 
x_list14 = filtrar_coordenadas(lista14)[0]
y_list14 = filtrar_coordenadas(lista14)[1] 
z_list14 = filtrar_coordenadas(lista14)[2]
x_list15 = filtrar_coordenadas(lista15)[0]
y_list15 = filtrar_coordenadas(lista15)[1] 
z_list15 = filtrar_coordenadas(lista15)[2]
x_list16 = filtrar_coordenadas(lista16)[0]
y_list16 = filtrar_coordenadas(lista16)[1] 
z_list16 = filtrar_coordenadas(lista16)[2]
x_list17 = filtrar_coordenadas(lista17)[0]
y_list17 = filtrar_coordenadas(lista17)[1] 
z_list17 = filtrar_coordenadas(lista17)[2]
x_list18 = filtrar_coordenadas(lista18)[0]
y_list18 = filtrar_coordenadas(lista18)[1] 
z_list18 = filtrar_coordenadas(lista18)[2] 
x_list19 = filtrar_coordenadas(lista19)[0]
y_list19 = filtrar_coordenadas(lista19)[1] 
z_list19 = filtrar_coordenadas(lista19)[2]
x_list20 = filtrar_coordenadas(lista20)[0]
y_list20 = filtrar_coordenadas(lista20)[1] 
z_list20 = filtrar_coordenadas(lista20)[2]
x_list21 = filtrar_coordenadas(lista21)[0]
y_list21 = filtrar_coordenadas(lista21)[1] 
z_list21 = filtrar_coordenadas(lista21)[2]
x_list22 = filtrar_coordenadas(lista22)[0]
y_list22 = filtrar_coordenadas(lista22)[1] 
z_list22 = filtrar_coordenadas(lista22)[2]
x_list23 = filtrar_coordenadas(lista23)[0]
y_list23 = filtrar_coordenadas(lista23)[1] 
z_list23 = filtrar_coordenadas(lista23)[2]
x_list24 = filtrar_coordenadas(lista24)[0]
y_list24 = filtrar_coordenadas(lista24)[1] 
z_list24 = filtrar_coordenadas(lista24)[2]
x_list25 = filtrar_coordenadas(lista25)[0]
y_list25 = filtrar_coordenadas(lista25)[1] 
z_list25 = filtrar_coordenadas(lista25)[2]
x_list26 = filtrar_coordenadas(lista26)[0]
y_list26 = filtrar_coordenadas(lista26)[1] 
z_list26 = filtrar_coordenadas(lista26)[2]
x_list27 = filtrar_coordenadas(lista27)[0]
y_list27 = filtrar_coordenadas(lista27)[1] 
z_list27 = filtrar_coordenadas(lista27)[2]
x_list28 = filtrar_coordenadas(lista28)[0]
y_list28 = filtrar_coordenadas(lista28)[1] 
z_list28 = filtrar_coordenadas(lista28)[2] 
x_list29 = filtrar_coordenadas(lista29)[0]
y_list29 = filtrar_coordenadas(lista29)[1] 
z_list29 = filtrar_coordenadas(lista29)[2] 
x_list30 = filtrar_coordenadas(lista30)[0]
y_list30 = filtrar_coordenadas(lista30)[1] 
z_list30 = filtrar_coordenadas(lista30)[2] 
#lista de datos filtrados coordenada x 
x_mean = [x_list1,x_list2,x_list3,x_list4,x_list5,x_list6,x_list7,x_list8,x_list9,x_list10,
          x_list11,x_list12,x_list13,x_list14,x_list15,x_list16,x_list16,x_list17,x_list18,
          x_list19,x_list20,x_list21,x_list22,x_list23,x_list24,x_list25,x_list26,x_list27,
          x_list28,x_list29,x_list30] 
#buque para convertir de str a float de la lista 
x = [float(f) for f in x_mean] 
x1_total = sum(x)/31 
print("Coordenadas geocentricas tomadas de las mediciones promedio")
print(f"coordenada x promedio: {str(round(x1_total,3))}")
#print(x1_total) 
#lista de datos filtrados coordenada y 
y_mean = [y_list1,y_list2,y_list3,y_list4,y_list5,y_list6,y_list7,y_list8,y_list9,y_list10,
          y_list11,y_list12,y_list13,y_list14,y_list15,y_list16,y_list17,y_list18,y_list19,
          y_list20,y_list21,y_list22,y_list23,y_list24,y_list25,y_list26,y_list27,y_list28,
          y_list29,y_list30] 
#buque para convertir de str a float de la lista
y2 = [float(g) for g in y_mean]
y2_total = sum(y2)/30
print(f"coordenada y promedio: {str(round(y2_total,3))}")
#print(y2_total) 
#lista de datos filtrados coordenada z 
z_mean = [z_list1,z_list2,z_list3,z_list4,z_list5,z_list6,z_list7,z_list8,z_list9,z_list10,
          z_list11,z_list12,z_list13,z_list14,z_list15,z_list16,z_list17,z_list18,z_list19,
          z_list20,z_list21,z_list22,z_list23,z_list24,z_list25,z_list26,z_list27,z_list28,
          z_list29,z_list30]
z3 = [float(h) for h in z_mean]
z3_total = sum(z3)/30 
print(f"coordenada z promedio: {round(z3_total,3)}")
#calculo de coordenadas medidas a coordenadas geodesicas 
#Transformación entre cartesianas geocéntricas (X, Y, Z) a geodésicas (λ,φ,h) 
#elipsoide de referencias valores de a y b 
a = 6378137
b = 6356752.314 
#funcion de exentricidad 
def ex(a,b):
    den = a**2 - b**2
    num = a**2
    exentricidad = den / num 
    den1 = a**2 - b**2
    num2 = b**2
    exentricidad_prin = den1/num2
    return [exentricidad , exentricidad_prin] 
e = ex(a,b)[0]
e_prim = ex(a,b)[1] 
#funcion convertir de radianes a metros
def radianes_a_grados(radianes):
    ra = 180 *(radianes/math.pi)
    return ra 
#funcion valor de p 
def p(x,y):
    p = math.sqrt(x**2 + y**2)
    return p 
p = p(x1_total,y2_total) 
#funcion de theta
def theta(z,a,p,b):
    Za = z*a
    Pb = p*b
    theta = math.atan(Za/Pb)
    return theta 
#ϴ = theta(z3_total,a,p,b)  #funcion en radianes 
theta_g = radianes_a_grados(theta(z3_total,a,p,b))
#funcion para sacar phi
def phi(z,e2,b,ϴ,p,e,a):
    den = z + (e2*b*math.sin(ϴ)**3)
    num = p - (e*a*math.cos(ϴ)**3)
    phi = math.atan(den / num)
    return phi  
angulo = phi(z3_total,e_prim,b,theta_g,p,e,a)
phi2 = radianes_a_grados(phi(z3_total,e_prim,b,theta_g,p,e,a))  #funcion a radianes 
#funcion para sacar N 
def N(a,e2,phi):
    num = math.sqrt(1-e2*math.sin(phi)**2)
    N = a / num
    return N 
N = N(a,e,phi2) 
#funcion para sacar h 
def h(p,phi,N):
    fraccion = p/math.cos(phi) 
    h = fraccion - N 
    return h 
h = h(p,angulo,N) 
#funcion para calcular lamba 
def lamba(y,x):
    lamda = math.atan(y/x) 
    return lamda 
 #funcion en radianes  
l = lamba(y2_total, x1_total)
lamba_g = radianes_a_grados(l)  
#coordenadas finales 
print("coordenadas Geodesicas promediadas")
#lamba es x 
#phi es y 
#h es z 
print("coordenada X geodesica es: " , round(phi2,3)) 
print("coordenada Y geodesica es:" , round(lamba_g,3))
print("coordenada z es: " , round(h,3)) 

"""   
def buscar_o(c):
    archivos_as = [] 
    for ruta,direccion,archivo in os.walk(c):
        for file in archivo:
            if file.endswith('.o'):
                archivos_as.append(file) 
    for s in archivos_as:
        with open(s) as lt:
            var = lt.readlines()[9:10]
            print(var.strip().split(" ")[0], var.strip().split(" ")[1], var.strip().split(" ")[3])
            
buscar_o(c)
"""
                
        

      
        



    
    

