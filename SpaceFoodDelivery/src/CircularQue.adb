package body CircularQue is

    package IntIO is new Ada.Text_IO.Integer_IO(Integer);
    use IntIO;

   capacity: Natural := 31;  -- *****************  storage space.

   subtype slotindex is natural range 0..(capacity - 1);  -- Natural implies >= 0.
   front, rear: slotindex := 0;  -- insert at front, remove from rear.
   mesnum : Natural range 0..(capacity-1) := 0; -- number in buff
   box: array(slotindex) of message; -- circular buffer
   maxMessages: Natural := capacity - 1; -- Integers >= 0.

   procedure acceptMessage(msg: in message) is  -- ** modify for placing in dual stacks
   begin
       if mesnum < maxMessages then  -- reserve space and insert msg.
         rear := (rear + 1) mod capacity;  -- implement wrap-around.
         box( rear ) := msg;
         mesnum := mesnum + 1;
       else
          put("ERROR - Message rejected - queue is full!"); new_line(2);
       end if;
   end acceptMessage;

   procedure retrieveMessage(msg: out message) is  -- ** modify in dual stacks to return highest priority food
   begin
      if mesnum > 0 then  -- remove message if buff not empty
          front := (front + 1) mod capacity;  -- front trails the next message by 1.  rear is the actual last msg.
          msg := box(front);
          mesnum := mesnum - 1;
      else
         put("ERROR - No message in the queue to retrieve!"); new_line(2);
      end if;
   end retrieveMessage;

   function CircularQueEmpty return Boolean is
   begin
      if mesnum > 0 then
         return False;
      else
         return True;
      end if;
   end CircularQueEmpty;

   function CircularQueFull return Boolean is  -- ** modify for dual stacks
      begin
      if mesnum < maxMessages then
         return False;
      else
         return True;
      end if;
   end CircularQueFull;

end CircularQue;
