with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Vehicles is

   procedure PrintItem(V : in Vehicle) is  --default print
   begin Put_Line("Much empty"); end PrintItem;

   overriding procedure PrintItem(C : in Car) is  --print for cars
   begin Put("Car:  " & C.Manu & "  Doors:  " & C.Doors'Img);
   end PrintItem;

   overriding procedure PrintItem(P : in Plane) is  --print for planes
   begin
      Put("Plane:  " & P.Manu & " Engines: " & P.Engines'Img & "   Doors: " & P.Doors'Img);
   end PrintItem;

   function Manuf(V : in Vehicle; W : in Vehicle'Class) return Boolean is  --default is equal
   begin return False;  end;

   overriding function Manuf(C : in Car; W : in Vehicle'Class) return Boolean is   -- equal functions for cars
   begin return W in Car and then C.Manu = Car(W).Manu;  end;

   overriding function Manuf(P : in Plane; W : in Vehicle'Class) return Boolean is -- equal functions for planes
   begin return W in Plane and then P.Manu = Plane(W).Manu; end;

end Vehicles;
