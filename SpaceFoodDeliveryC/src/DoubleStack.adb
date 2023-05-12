package body DoubleStack is

    package IntIO is new Ada.Text_IO.Integer_IO(Integer);
   use IntIO;

   capacity: Natural := 27;  -- *****************  storage space.
   meatTop : Natural range 0 .. capacity -1 := 0;
   vegTop: Natural range 0 .. capacity-1 := capacity-1;
   subtype slotindex is natural range 0..(capacity - 1);  -- Natural implies >= 0.
   box: array(slotindex) of message; -- circular buffer



   procedure meatpush(msg: in message) is -- meat stack push procedure
   begin
      if meatTop < (vegTop -1) then
         meatTop := meatTop +1;
         box(meatTop) := msg;
      else
         put("Error - stack full");
      end if;
   end meatpush;

   procedure vegpush(msg: in message) is --veg stack push prodecure
   begin
      if vegTop > (meatTop +1) then
         vegTop := vegTop -1;
         box(vegTop) := msg;
      else
         Put("Error - stack full");
      end if;
   end vegpush;

   function meatPop return message is --meat pop function returning pop message
   begin
      if meatTop /= 0 then
         meatTop := meatTop -1;
         return box(meatTop +1);
      else
         Put("nothing to be sold");
         return box(meatTop -1);
      end if;
   end meatPop;

   function vegPop return message is -- veg pop returns message that poped
   begin
      if vegTop < capacity then
         vegTop  := vegTop +1;
         return box(vegTop-1);
      else
         Put("Nothing to sell");
         return box(vegTop-1);
      end if;
   end vegPop;

   procedure retrieveMessage(msg: out message) is -- if there is meat to sell then it sells meat if not veg
   begin
      if  meatTop  > 0 then  -- obtain meat product
          msg := meatPop;
      elsif  vegTop <  21 then
          msg := vegPop;
       else
         Put("Nothing to sell"); New_Line;
      end if;
   end retrieveMessage;

   function spaceAvailable return Boolean is -- if there is space then then it returns true
   begin
      if meatTop + (capacity - vegTop)>= capacity -1 then
         return False;
      else
         return True;
      end if;
   end spaceAvailable;

   function StackEmpty return Boolean is -- if it is empty then it returns true
   begin
      if meatTop /= 0 or vegTop /= capacity then
         return False;
      else
         return True;
      end if;
   end StackEmpty;



end DoubleStack;
