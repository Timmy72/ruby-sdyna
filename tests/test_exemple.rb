# encoding: utf-8

require 'test/unit'
require_relative "../src/exemple"

module SDYNA
	class ExempleTest < Test::Unit::TestCase
		def test_exemples
			x = Variable.new("x", [true,false])
			y = Variable.new("y", [true,false])
			
			e1 = Exemple.new( {x=>true,y=>false}, 0.0 )
			e2 = Exemple.new( {x=>false,y=>true}, 4.0 )
			e3 = Exemple.new( {x=>true,y=>false}, 0.0 )
			e4 = Exemple.new( {x=>true,y=>false}, 0.0 )
			e5 = Exemple.new( {x=>false,y=>false}, 1.0 )
			e = [e1,e2,e3,e4,e5]
			assert_in_delta(5.0, Exemple.chi_deux( e, x ), 0.001)
			assert_in_delta(5.0, Exemple.chi_deux( e, y ), 0.001)
			assert_equal("y", Exemple.select_attr( e, [x,y] ).label)
			
			e10 = Exemple.new( {x=>true,y=>false}, true )
			e11 = Exemple.new( {x=>false,y=>true}, false )
			e12 = Exemple.new( {x=>true,y=>false}, true )
			e13 = Exemple.new( {x=>true,y=>false}, false )
			e14 = Exemple.new( {x=>false,y=>false}, false )
			e = [e10,e11,e12,e13,e14]
			assert_in_delta(20.0/9.0, Exemple.chi_deux( e, x ), 0.001)
			assert_in_delta(1.0/1.2, Exemple.chi_deux( e, y ), 0.001)
			assert_equal("x", Exemple.select_attr( e, [x,y] ).label)
			assert_equal(1.0, Exemple.aggregate( [e10,e12,e13], x )[{x=>true}])
			assert_equal(0.5, Exemple.aggregate( [e11,e14], y )[{y=>true}])
			assert_equal(0.0, Exemple.aggregate( [e11,e14], x )[{x=>true}])
			assert_equal(0.6, Exemple.aggregate( e, x )[{x=>true}])
			assert_equal(0.2, Exemple.aggregate( e, y )[{y=>true}])
			
			assert_equal(0.0, Exemple.chi_deux( [], x ))
			assert_equal(0.0, Exemple.chi_deux( [e10], x ))
		end
	end
end
