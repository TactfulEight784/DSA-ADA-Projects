with Ada.text_IO; use Ada.Text_IO;

generic
   type message is private;

   --func is meat(message) return boolean; this allows it to see if mesage is meat then push into which side of teh stack

   --define here and right body in gatekeeper so it can be used here

   --might have to put it into gatekeeper and add ismeat into package circular queue parameters
   -- ismeat(foodIn : Food_pack)
       --if getfood.foodpackshimpment 'M' return true.

package DoubleStack is

   procedure retrieveMessage(msg: out message);

   function StackEmpty return Boolean;

   procedure vegpush(msg: in message);

   procedure meatpush(msg: in message);

   function vegPop return message;

   function meatPop return message;

   function spaceAvailable return Boolean;

   --Add method (function or procedure) for inserting at front of queue here and in body.

 end DoubleStack;
