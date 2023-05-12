with Ada.Unchecked_Deallocation;

generic
   type element is tagged limited private;
   with function "="(I,E: element'Class) return Boolean;  --overloading = to compare equality between multiple objects

package Linkedlist is
   type DList is private;
   type elementPtr is access all element'Class;

   procedure makeHead(list: in out DList);
   function ListSize(list: in DList) return Integer;

   procedure InsertAfter(list: in out DList; Item: in elementPtr);
   procedure InsertBefore(list: in out DList; Item: in elementPtr);

   generic
   with procedure Process(I : element'Class);
   procedure ManuealMove(list : in DList);

   function FindItem(list : in DList; C : elementPtr) return elementPtr;
   function Delete(list : in out DList; C : elementPtr) return elementPtr;

private
   type Node;
   type nodePtr is access Node;

   type Node is record
      Data : elementPtr;
      Next, prev : nodePtr;
   end record;

   type DList is record
      count : Integer := 0;
      Head : nodePtr;
   end record;
end Linkedlist;
