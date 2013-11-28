
require "p10lppt13.rb"

require "test/unit"

# Clase con las pruebas unitarias de la practica
class TestP10lppt13 < Test::Unit::TestCase

  # Metodo de los tests 
  def test_prueba
    
    @m1 = Densa.new(2,2,[[1,2],[3,4]])
	@m2 = Densa.new(3,3,[[1,2,4],[6,5,8],[2,5,3]])
	@m3 = Dispersa.new(3,3, 0 => { 0 => 2, 2 => 1 })
                          
    assert_equal "1\t2\t\n3\t4\t\n", @m1.to_s
	assert_not_equal "4\t2\t\n3\t4\t\n", @m1.to_s
	assert_not_nil @m3.pos[0][0]
	assert_not_same @m3.pos[0][0], @m1.pos[0][2]
    
  end
  
end
