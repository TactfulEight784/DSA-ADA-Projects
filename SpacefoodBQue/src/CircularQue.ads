with Ada.text_IO; use Ada.Text_IO;

generic
    type message is private;
    capacity : Natural := 27; --default value

 package CircularQue is

   procedure acceptMessage(msg: in message);

   procedure retrieveMessage(msg: out message);

   function circularQueEmpty return Boolean;

   function circularQueFull return Boolean;

   --Add method (function or procedure) for inserting at front of queue here and in body.

 end CircularQue;
