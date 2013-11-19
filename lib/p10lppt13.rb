require "fraccion.rb"

class Matriz

	attr_reader :nfil, :ncol

	# Metodo initilize de la clase base
	def initialize(nfil, ncol)
		@nfil = nfil
		@ncol = ncol
	end
	
	# Getter de nfil
	def filas
		@nfil
	end
	
	# Getter de ncol
	def colum
		@ncol
	end
	
	# Metodo para convertir la matriz a string
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
	
	# Metodo para sumar dos matrices
	def +(other)
		if ((@nfil != other.nfil) || (@ncol != other.ncol))
			puts "No se pueden restar las matrices"
		else 
		  elemento = Array.new(0)
			for i in 0...filas
				fila = Array.new(0)
				for j in 0...colum
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
	
	# Metodo para restar dos matrices
	def -(other)
		if ((@nfil != other.nfil) || (@ncol != other.ncol))
			puts "No se pueden restar las matrices"
		else
			elemento = Array.new(0)
			for i in 0...filas
				fila = Array.new(0)
				for j in 0...colum
					fila << pos[i][j] - other.pos[i][j]
				end
				elemento << fila
			end
		end
		Matriz.new(@nfil, @ncol, elemento)
	end
	
	# Metodo para multiplicacion dos matrices
	def por(other)
		if ((@nfil != other.ncol) || (@ncol != other.nfil))
			puts "No se pueden multiplicarr las matrices"
		else
			elemento = Array.new(0)
			for i in 0...nfil
				fila = Array.new(0)
				for j in 0...other.ncol
					aux = 0
					for k in 0...ncol
						aux += pos[i][k] * other.pos[k][j]
					end
					fila << aux
				end
				elemento << fila
			end
		end
		Matriz.new(@nfil, other.ncol, elemento)
	end
	
	# Metodo para multiplicacion dos matrices
	def porf(other)
		if ((@nfil != other.ncol) || (@ncol != other.nfil))
			puts "No se pueden multiplicarr las matrices"
		else
			elemento = Array.new(0)
			for i in 0...nfil
				fila = Array.new(0)
				for j in 0...other.ncol
					aux = Fraccion.new(1,1)
					aux = aux - aux
					for k in 0...ncol
						aux += pos[i][k] * other.pos[k][j]
					end
					fila << aux
				end
				elemento << fila
			end
		end
		Matriz.new(@nfil, other.ncol, elemento)
	end
	
	# Metodo para multiplicar una matriz por un escalar
	def *(other)
		elemento = Array.new(0)
		for i in 0...filas
			fila = Array.new(0)
			for j in 0...colum
				fila << pos[i][j]*other
			end
			elemento << fila
		end
		Matriz.new(@nfil, @ncol, elemento)
	end
	
	# Metodo para hallar la traspuesta de una matriz
	def trasponer
		elemento = Array.new(0)
		for i in 0...colum
			fila = Array.new(0)
			for j in 0...filas
				fila << pos[j][i]
			end
			elemento << fila
		end
		Matriz.new(@ncol, @nfil, elemento)
	end
	
	
	# Metodo para convertir la matriz en un vector
	def vectorizar
		aux = Array.new(0)
		for i in 0...colum
			for j in 0...filas
				aux << pos[i][j]
			end
		end
		Array.new(aux)
	end
	
end

# Clase de Matrices Densas
class Densa < Matriz
	
	attr_reader :pos
	
	def initialize(nfil, ncol, pos)
		super(nfil, ncol)
		@pos = Array.new(pos)
	end
	
	def [](i)
		@data[i]
	end

	def []=(i,value)
		@data[i] = value
	end
	
end

# Clase de Vectores dispersos
class VectorDisperso
	attr_reader :vector
	
	def initialize(h = {})
		@vector = Hash.new(0)
		@vector = @vector.merge!(h)
	end

	def [](i)
		@vector[i] 
	end

	def to_s
		@vector.to_s
	end
end

# Clase de Matrices Dispersas
class Dispersa < Matriz
	attr_reader :pos
	
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

	def [](i)
		@pos[i]
	end

	def col(j)
		c = {}
		for r in @pos.keys do
			c[r] = @pos[r].vector[j] if @pos[r].vector.keys.include? j
		end
		VectorDisperso.new c
	end
	
end
