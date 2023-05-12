with Ada.Text_IO; use Ada.Text_IO;
with linkedList;
package body MakeCar is
   package intIo is new ada.Text_IO.Integer_IO(Integer);
   use intIo;

   function UserString return string is
      t: string(1..4) := (others => ' ');
      last : Integer;
   begin
      put("Enter Manufacturer: ");
      Get_Line(t,last);
      return t;
   end UserString;

   function NumberDoors return Integer is
      t : Integer;
   begin
      put("Enter number of Doors: ");
      Get(t);
      Skip_Line;
      return t;
   end NumberDoors;


      procedure PrintItem(V : in vehical) is  --default print
   begin Put_Line("Much empty"); end PrintItem;

   procedure AssignNumDoors(aCar : in out Car; N : in Integer) is
   begin
      aCar.NumDoors := N;
   end AssignNumDoors;

   procedure AssignManufacturer(aCar : in out Car; Manu: in String) is
   begin
      aCar.Manufacturer := manu;
   end AssignManufacturer;

   procedure PrintDoors(aCar : in Car) is
   begin
      put("Num of Doors");
      put(aCar.NumDoors);
      New_Line;
   end PrintDoors;

   procedure PrintString4(PrtStr: String) is
   begin
      for I in 1 .. 4 loop
         put(PrtStr(I));
      end loop;
   end PrintString4;

   procedure PrintManufacturer(aCar : in Car) is
   begin
      put("Manufacturer is ");
      PrintString4(aCar.Manufacturer);
      New_Line;
   end PrintManufacturer;

   procedure identify(aCar : in Car)is
   begin
      put("Car with ");
      put(aCar.NumDoors);
      put(" doors");
      put(" Made by ");
      PrintString4(aCar.Manufacturer);
      New_Line;
   end identify;

   function equality(V : in vehical; W : in vehical'Class) return Boolean is  --default is equal
   begin
      return False;
   end equality;


   overriding procedure PrintItem(aCar : in Car) is  --print for planes
   begin
      Put("Car made by:  "& acar.Manufacturer & " Number of Doors: " & aCar.NumDoors'Image);
   end PrintItem;

   overriding function equality(aCar : in Car; V : in vehical'Class) return Boolean is   -- equal functions for cars
   begin
      return V in Car and then aCar.Manufacturer = Car(V).Manufacturer;
   end equality;

end MakeCar;
