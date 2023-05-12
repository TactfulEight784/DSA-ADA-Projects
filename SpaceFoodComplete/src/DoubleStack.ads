with Ada.text_IO; use Ada.Text_IO;

generic
   type message is private;
   capacity : Natural;

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
