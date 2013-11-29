require "fraccion.rb"

# Clase base Matriz, que guarda el numero de filas y columnas
class Matriz
	
	#Variable que almacena el numero de filas de la matriz
	attr_reader :nfil
	#Variable que almacena el numero de columnas de la matriz
	attr_reader :ncol
	
	# Metodo initilize de la clase base
	def initialize(nfil, ncol)
		@nfil = nfil
		@ncol = ncol
	end
	
	# Getter de nfil (devuelve el numero de filas de la matriz)
	def filas
		@nfil
	end
	
	# Getter de ncol (devuelve el numero de columnas de la matriz)
	def colum
		@ncol
	end
	
	# Metodo para convertir la matriz a string (a una cadena)
	def to_s
		aux = ""
		@nfil.times do |i|
			@ncol.times do |j|
				aux << "#{pos[i][j]}\t"
			end
			aux << "\n"
		end
		aux
	end
        
	def encontrar
		@nfil.times do |i|
			@ncol.times do |j|
				if (self.pos[i][j] != nil) 
				    if yield(pos[i][j]) 
						return [i,j]
					end 
				end
			end
		end
	end
	
	# Metodo para sumar dos matrices (si tienen la misma dimension)
	def +(other)
		# Primero se comprueba si se pueden sumar (si tienen la misma dimension)
		if ((@nfil != other.nfil) || (@ncol != other.ncol))
			puts "No se pueden sumar las matrices"
		else 
		  elemento = Array.new(0)
			@nfil.times do |i|
				fila = Array.new(0)
				@ncol.times do |j|
					if self.pos[i][j] == nil && other.pos[i][j] != nil
						fila << other.pos[i][j]
					elsif self.pos[i][j] != nil && other.pos[i][j] == nil
						fila << pos[i][j]
					elsif self.pos[i][j] == nil && other.pos[i][j] == nil
						fila << 0
					else
						fila << pos[i][j] + other.pos[i][j]
					end     			   
				end
				elemento << fila
			end
		Densa.new(@nfil, @ncol, elemento)
		end
	end	
	
	# Metodo para restar dos matrices (si tienen la misma dimension)
	def -(other)
		# Primero se comprueba si se pueden restar (si tienen la misma dimension)
		if ((@nfil != other.nfil) || (@ncol != other.ncol))
			puts "No se pueden restar las matrices"
		else 
		  elemento = Array.new(0)
			@nfil.times do |i|
				fila = Array.new(0)
				@ncol.times do |j|
					if self.pos[i][j] == nil && other.pos[i][j] != nil
						fila << -other.pos[i][j]
					elsif self.pos[i][j] != nil && other.pos[i][j] == nil
						fila << pos[i][j]
					elsif self.pos[i][j] == nil && other.pos[i][j] == nil
						fila << 0
					else
						fila << pos[i][j] - other.pos[i][j]
					end     			   
				end
				elemento << fila
			end
		Densa.new(@nfil, @ncol, elemento)
		end
	end
	
	# Metodo para hallar el primer valor no nulo de una matriz
	def primervalor
		for i in 0...@nfil
			for j in 0...@nncol
				if (self.pos[i][j] != nil) 
				    return self.pos[i][j]
				end
			end
		end
	end
	
	# Metodo para hallar el valor maximo de los elementos de una matriz
	def max
		acum = pos[0][0]
		for i in 0...filas
			for j in 0...colum
				if self.pos[i][j] != nil
					if pos[i][j] > acum
						acum = pos[i][j]
					end
				end     			   
			end
		end
		acum
	end
	
	# Metodo para hallar el valor minimo de los elementos de una matriz
	def min
		acum = pos[0][0]
		for i in 0...filas
			for j in 0...colum
				if self.pos[i][j] != nil
					if pos[i][j] < acum
						acum = pos[i][j]
					end
				end     			   
			end
		end
		acum
	end
	
	# Metodo para multiplicacion dos matrices
	def por(other)
		# Primero se comprueba si se pueden multiplicar (las dimensiones deben ser nxm y mxn)
		if ((@nfil != other.ncol) || (@ncol != other.nfil))
			puts "No se pueden multiplicarr las matrices"
		else
			elemento = Array.new(0)
			@nfil.times do |i|
				fila = Array.new(0)
				other.ncol.times do |j|
					aux = 0
					@ncol.times do |k|
						if self.pos[i][k] != nil && other.pos[i][k] != nil
							aux += pos[i][k] * other.pos[k][j]
						end
					end
					fila << aux
				end
				elemento << fila
			end
		end
		Densa.new(@nfil, other.ncol, elemento)
	end
	
	# Metodo para multiplicacion dos matrices
	def porf(other)
		# Primero se comprueba si se pueden multiplicar (las dimensiones deben ser nxm y mxn)
		if ((@nfil != other.ncol) || (@ncol != other.nfil))
			puts "No se pueden multiplicarr las matrices"
		else
			elemento = Array.new(0)
			@nfil.times do |i|
				fila = Array.new(0)
				other.ncol.times do |j|
					aux = Fraccion.new(1,1)
					aux = aux - aux
					@ncol.times do |k|
						if (self.pos[i][k] != nil && other.pos[i][k] != nil)
							aux += pos[i][k] * other.pos[k][j]
						else
							aux << pos[i][j]
						end
						fila << aux
					end
				end
				elemento << fila
			end
		end
		Densa.new(@nfil, other.ncol, elemento)
	end
	
	# Metodo para multiplicar una matriz por un escalar
	def *(other)
		elemento = Array.new(0)
		@nfil.times do |i|
			fila = Array.new(0)
			@ncol.times do |j|
				if (pos[i][j] != nil)
					fila << pos[i][j]*other
				else
					fila << pos[i][j]
				end
			end
			elemento << fila
		end
		Densa.new(@nfil, @ncol, elemento)
	end
	
	# Metodo para hallar la traspuesta de una matriz
	def trasponer
		elemento = Array.new(0)
		@ncol.times do |i|
			fila = Array.new(0)
			@nfil.times do |j|
				fila << pos[j][i]
			end
			elemento << fila
		end
		Densa.new(@ncol, @nfil, elemento)
	end
	
	
	# Metodo para convertir la matriz en un vector
	def vectorizar
		aux = Array.new(0)
		@ncol.times do |i|
			@nfil.times do |j|
				aux << pos[i][j]
			end
		end
		Array.new(aux)
	end
	
end

# Clase de Matrices Densas
class Densa < Matriz
	
	#Vector que almacena los valores de la matriz(Array de arrays, en el que cada array es una fila).
	attr_reader :pos

	# Constructor de la clase Matriz Densa
	def initialize(nfil, ncol, pos)
		super(nfil, ncol)
		@pos = Array.new(pos)
	end
	
	# Metodo de acceso a las filas
	def [](i)
		@data[i]
	end
	
	# Metodo de acceso a las posiciones
	def []=(i,value)
		@data[i] = value
	end
	
end

# Clase de Vectores dispersos
class VectorDisperso
  
	#Vector que almacena los valores de la matriz.
	attr_reader :vector
	
	# Constructor de la clase VectorDisperso
	def initialize(h = {})
		@vector = Hash.new(0)
		@vector = @vector.merge!(h)
	end
	
	# Metodo para acceder a una posicion
	def [](i)
		@vector[i] 
	end
	
	# Metodo para convertir a un string
	def to_s
		@vector.to_s
	end
end

# Clase de Matrices Dispersas
class Dispersa < Matriz
  
	#Vector que almacena los valores de la matriz(Array de arrays, en el que cada array es una fila).
	attr_reader :pos
	
	# Constructor de la clase Matriz Dispersa
	def initialize(nfil, ncol, h = {})
		super(nfil, ncol)
		@pos = Hash.new({})
		for k in h.keys do
		@pos[k] = if h[k].is_a? VectorDisperso
						h[k]
					 else 
						@pos[k] = VectorDisperso.new(h[k])
                     end
		end
	end
	
	# Metodo para acceder a una posicion de la matriz
	def [](i)
		@pos[i]
	end
	
	# Metodo para acceder a una columna de la matriz
	def col(j)
		c = {}
		for r in @pos.keys do
			c[r] = @pos[r].vector[j] if @pos[r].vector.keys.include? j
		end
		VectorDisperso.new c
	end
	
end
