with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Linkedlist is

   procedure Free is new Ada.Unchecked_Deallocation(node, nodePtr);

   procedure makeHead(list : in out DList) is     -- makes an empty list that points back to its self
      Head : nodePtr := new node;
   begin
      list.count := 0;
      Head.Next := Head;
      list.Head := Head;
      head.data := null;
      head.prev := head;
   end;

   function ListSize(list: in DList) return Integer is
   begin
      return list.count;
   end ListSize;    -- get number of items in list

   procedure InsertAfter(list: in out DList; Item: in elementPtr) is
      newNode : nodePtr := new node;
   begin
      newNode.Data := Item;
      newNode.next := list.head.next;
      newNode.prev := list.head;
      newNode.next.prev := newNode;
      newNode.prev.next := newNode;
      list.count := list.count + 1;
   end;

   procedure InsertBefore(list: in out DList; Item: in elementPtr) is
      newNode : nodePtr := new node;
   begin
      newNode.Data := Item;
      newNode.prev := list.head.prev;
      newNode.next := list.head;
      newNode.prev.next := newNode;
      newNode.next.prev := newNode;
      list.count := list.count + 1;
   end;

   procedure ManuealMove(list : in DList) is
      newNode: nodePtr;
   begin
      NewNode := list.Head.Next;
      while newNode /= list.Head loop
         Process(newNode.Data.all);
         newNode := newNode.Next;   New_Line;
      end loop;
   end;

   function FindItem(list : in DList; C : elementPtr) return elementPtr is
        newNode: nodePtr;
     begin
        newNode := list.Head.Next;
        while newNode /= list.Head loop
           if C.all = newNode.Data.all then
              return newNode.Data;
           end if;
           newNode := newNode.Next;
        end loop;
        return null;
     end;

   function Delete(list : in out DList; C : elementPtr) return elementPtr is
      newNode: nodePtr;    pt : elementPtr;
   begin
      newNode := list.Head.Next;
      while newNode /= list.Head loop
         if C.all = newNode.Data.all then
            newNode.prev.Next := newNode.Next;
            newNode.Next.prev := newNode.prev;
            pt := newNode.Data; Free(newNode);
            list.count := list.count - 1;
            return pt;
         end if;
         newNode := newNode.Next;
      end loop;
      return null;
   end;

end Linkedlist;
