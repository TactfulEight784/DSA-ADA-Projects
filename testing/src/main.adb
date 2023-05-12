with Ada.Text_IO; use Ada.Text_IO;
Debug;
procedure Main is
   procedure proc(x : in out Integer; y : in out Integer) is
   begin
      x := x+y;
      y:= x+y;
      Put_Line(integer'Image(x));
      Put_Line(integer'Image(y));
   end proc;
   a : Integer := 2;
   b : Integer := 3;
begin
   proc(a,b);
   Put_Line(integer'Image(a));
   Put_Line(integer'Image(b));
   proc(b , b);
   Put_Line(integer'Image(a));
   Put_Line(integer'Image(b));
end Main;
