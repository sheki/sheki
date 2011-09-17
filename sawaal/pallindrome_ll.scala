

/**
*Program to check if a linked list is a pallindrome.
* Problem : http://geeksforgeeks.org/?p=1072
*@author Abhishek Kona
*/


case class Node(val  data : Int, val next : Option[Node])
{
  override def toString(): String = "node "+data
}

def printLinkedList (  node : Option[Node] ) : String  ={
  node match {
    case None => " " 
    case Some(Node(data,next)) => data+" "+printLinkedList(next)
  }
}

def isPallindrome(head : Option[Node]   ) : Boolean =
{   
    
      
}

val sizeLL= Console.readInt
var next :Option[Node] = None
for (i <- 0 until sizeLL)
{
    val t = new Node (Console.readInt , next)
    next= Some(t)
    //TODO fill up the driver
}
Console.println(printLinkedList(next))


