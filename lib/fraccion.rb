#require "gcd.rb"

#############################################################
# Clase Fraccion de la practica #7 de LPP                   #
#############################################################
#Clase para crear instancias de Fraccion
class Fraccion 
  
    # Variable que almacena el numerador de la fraccion
    attr_reader :numer
    # Variable que almacena el denominador de la fraccion
    attr_reader :denomin
    
    # Incluimos el módulo Comparable
    include Comparable
  
    # Metodo de inicializacion de la clase Fraccion
    def initialize(n,d) 
      @numer, @denomin = n, d
    end
	
	#Maximo comun divisor
	def gcd(u, v)
	  u, v = u.abs, v.abs
	  while v != 0
		u , v = v, u % v
	  end
	  u
	end
	#############################################################
    #  Funciones basicas de la clase                            #
    #############################################################
    
	# Getter del num
    def num()
      return @numer
    end

	# Getter del denom
    def denom()
      return @denomin
    end
  
	# Funcion para simplificar y mostrar la fraccion en formato reducido
    def simplificar
      aux = gcd(self.numer, self.denomin)                        # MCD entre num y denom
      Fraccion.new(self.numer/aux, self.denomin/aux)			 # Simplificamos la fraccion que le pasemos
    end 
    
    #Mostramos los atributos en un string
    def to_s
      "#{@numer}/#{@denomin}"
    end
   
	#Mostramos los atributos en float
    def to_f
      @numer/@denomin.to_f
    end
   
    #############################################################
    #  Funciones de igualdad, absoluto, reciproco y opuesto     #
    #############################################################
    
    # Funcion de comparar igualdad: Comparamos la fraccion implicita, con la que le pasamos como parametro
    def ==(other)
		if other.class.to_s != "Fraccion"
			other = Fraccion.new(other,1)
		end
		if ((@numer == other.numer) and (@denomin == other.denomin))
			true		# Si el numerador y el denominador de la implicita coinciden con los 
						# de la pasada por parametro, entonces las fracciones son iguales (true)
		else
			false		# Si no, son distintas (false)
		end  
    end
  
	# Funcion que devuelve la funcion en valor absoluto
	def absoluto
		@numer = @numer.abs
		@denomin = @denomin.abs
		Fraccion.new(@numer,@denomin)
	end
  
	#Obtiene la fraccion reciproca a la implicita
	def reciprocal
		Fraccion.new(@denomin,@numer)
	end
  
	# Funcion que calcula la fraccion opuesta
	def opuesto
		Fraccion.new(-@numer,@denomin)
	end
  
	#############################################################
    #  Funciones de suma, resta, multiplicacion y division      #
    #############################################################
	
	# Necesitamos hallar el minimo comun multiplo para la suma y la resta
	def mcm(n, m)
		aux=gcd(n,m)
		(n/aux)*m 
	end
	
	# Realizamos la division de la fraccion implicita con recibida como parametro
	def /(other)
		temp = Fraccion.new(@numer*other.denomin, @denomin*other.numer)
		temp.simplificar
	end
	
	# Realizamos la suma de la fraccion implicita con recibida como parametro
	def +(other)             
		if(other.instance_of?Fixnum)
                        temp=other
                        other=Fraccion.new(temp,1)
                end
		
		aux = mcm(@denomin, other.denomin)                                                    
		temp = Fraccion.new(((aux/@denomin)*@numer)+((aux/other.denomin)*other.numer),aux)               
		temp.simplificar
	end
    
    # Realizamos la resta de la fraccion implicita con recibida como parametro
	def -(other)
		aux = mcm(@denomin, other.denomin)
		temp = Fraccion.new(((aux/@denomin)*@numer)-((aux/other.denomin)*other.numer),aux)
		temp.simplificar                                 
	end
   
	# Realizamos la multiplicacion de la fraccion implicita con recibida como parametro
	def *(other)
		temp=Fraccion.new(@numer*other.numer, @denomin*other.denomin) 
		temp.simplificar                                                
	end
	
	#############################################################
    #  Funciones de modulo y comparacionales (menor, mayor,     #
    #  menor o igual y mayor o igual)
    #############################################################
  
	#Operador para obtener el resto
	def %(other)										#Obtenemos el resto de la division de dos fracciones								
		aux1 = self.numer * other.denomin				#Multiplicamos el numerador de la primera entre el denominador de la segunda
		aux2 = self.denomin * other.numer				#Multiplicamos el denominador de la primera entre el numerador de la segunda
		resto = aux1%aux2								#Obtenemos el Resto de la fraccion resultante
	end
	
	#Operador comparable
	def <=>(other)
		self.to_f <=> other.to_f
	end
	
	#Metodo coerce para cambiar instancia por parametro.
	def coerce(other)
		#aux = Fraccion.new(other,1)
		[self,other]
	end

end
