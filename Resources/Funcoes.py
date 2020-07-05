def somar_valores_da_lista(valores):
    """
    Soma todos os valores presentes dentro da lista
        
    Parameters
    valores : list
        Lista contendo os valores que serão somados
    
    Return
    soma_dos_valores : float
        Resultado da soma dos valores. Limitado a duas casas decimais
    
    """
    soma_dos_valores = 0
    for i in valores:
        soma_dos_valores +=  float(i)
    return ("%0.2f" % soma_dos_valores)

def string_to_list(palavra):
    """
    Converte uma string de números em uma lista, onde cada número da string vai para uma posição da lista
    Remove "," e "e", já que espera-se que a string seja escrita da seguinte forma: "1, 2 e 3" ou "1 e 2" ou "1, 2, 3 e 4" e etc

    Parameters
        palavra : str
            String contendo os valores que serão convertidos e dispostos nas posições de uma lista
        
    Return
        lista : list
            Lista com os valores convertidos e com os caracteres "," e "e" removidos
    
    """
    palavra = palavra.replace(',', '')
    palavra = palavra.replace('e', '')
    lista = palavra.split()
    return lista