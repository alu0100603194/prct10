require "p10lppt13.rb"

describe Matriz do
        before :each do
                @m1 = Densa.new(2,2,[[1,2],[3,4]])
                @m2 = Densa.new(3,3,[[1,2,4],[6,5,8],[2,5,3]])
                @m3 = Dispersa.new(3,3,1 => { 1 => 2, 3 => 1 })
        end
        
        # Comprobacion de que se crea bien la matriz
        describe "Comprobamos el numero de...\n" do
                it " - Filas para una matriz densa 3x3\n" do
                        @m2.nfil.should eq(3)
                end
                it " - Columnas de una matriz densa 3x3\n" do
                        @m2.ncol.should eq(3)
                end
                it "Acceso al elemento [0][0]" do
                        @m1.pos[0][0].should eq(1)
                end
                it "Acceso al elemento [0][1]" do
                        @m1.pos[0][1].should eq(2)
                end
                it "Acceso al elemento [1][0]" do
                        @m1.pos[1][0].should eq(3)
                end
                it "Acceso al elemento [1][1]" do
                        @m1.pos[1][1].should eq(4)
                end
                it " - Filas para una matriz dispersa 3x3\n" do
                        @m3.nfil.should eq(3)
                end
                it " - Columnas de una matriz dispersa 3x3\n" do
                        @m3.ncol.should eq(3)
                end
                it "Acceso al elemento [1][1]" do
                        @m3[1][3].should eq(1)
                end
        end
        
end
