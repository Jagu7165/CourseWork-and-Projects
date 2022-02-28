//Jorge Aguinaga
//CS3230 Lab03

//Tile class (top level)
public abstract class Tile {
	public boolean matches(Tile other){
		
		if(other==null)
        { 
            return false;
        } 
        if(this == other) 
        {
            return true;
        }  
		if(getClass() == other.getClass())
        {
            return true;
        }else{
		    return false;
        }
	}
}