//Solution to code jam problem : http://goo.gl/B2tS9
def minScalarProduct( x : List[Int],y : List[Int] ) : Long = {

    val sortedX = x.sortWith(_<_) 
    val sortedY= y.sortWith(_>_)

    def scalarProduct(x: List[Int], y: List[Int] ) : Long = x  match {
    case Seq() => 0
    case x1::xs1 => x1 * y.head + scalarProduct ( xs1, y.tail ) 
  }
  scalarProduct(sortedX,sortedY)
}  

def processInput(source: io.Source) {
  val groups = source.getLines.drop(1).grouped(3) 

  groups.zipWithIndex foreach { e =>  
       val solution = minScalarProduct ( e._1(1).split(" ").map(_.toInt).toList,  e._1(2).split(" ").map(_.toInt).toList   ) 
       println("Case #"+(e._2+1)+": "+solution)
  }
}
//input from the file input.txt
processInput(io.Source.fromFile("input.txt"))
