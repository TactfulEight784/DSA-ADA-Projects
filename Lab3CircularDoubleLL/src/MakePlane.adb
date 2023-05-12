with Ada.Text_IO; use Ada.Text_IO;
with linkedList;
package body MakePlane is
   package intIo is new ada.Text_IO.Integer_IO(Integer);
   use intIo;

      function UserString return string is
      t: string(1..8) := (others => ' ');
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
      get(t);
      return t;
   end NumberDoors;

      function NumberEngines return Integer is
      t : Integer;
   begin
      put("Enter number of Engines: ");
      get(t);
      Skip_Line;
      return t;
   end NumberEngines;

   procedure AssignNumDoors(aPlane : in out Plane; N : in Integer) is
   begin
      aPlane.NumDoors := N;
   end AssignNumDoors;

   procedure AssignManufacturer(aPlane : in out Plane; Manu: in String) is
   begin
      aPlane.Manufacturer := manu;
   end AssignManufacturer;

   procedure AssignNumEngine(aPlane : in out Plane; NE : in Integer) is
   begin
      aPlane.NumEngines := NE;
   end AssignNumEngine;


   procedure PrintString8(PrtStr: String) is
   begin
      for I in 1 .. 8 loop
         put(PrtStr(I));
      end loop;
   end PrintString8;

   procedure PrintPlane(aPlane : in Plane) is
   begin
      put("Num soors for plane= ");
      put(aPlane.NumDoors);
      New_Line;
      put("Number of Engines= ");
      put(aPlane.NumEngines);
      New_Line;
      put("Made by ");
      PrintString8(aPlane.Manufacturer);
      New_Line;
   end PrintPlane;


   procedure identify(aPlane : in Plane)is
   begin
      put("Plane with ");
      put(aPlane.NumDoors);
      put(" doors");
      put(aPlane.NumEngines);
      put(" Engines, made by ");
      PrintString8(aPlane.Manufacturer);
      New_Line;
   end identify;

   overriding procedure PrintItem(P : in Plane) is  --print for cars
   begin
      Put("Plane made by:  " & p.Manufacturer & " Number of doors: " & p.NumDoors'Image & " Number of Engines: " & p.NumEngines'Image);
   end PrintItem;

   overriding function equality(P : in Plane; W : in vehical'Class) return Boolean is -- equal functions for planes
   begin return W in Plane and then P.Manufacturer = Plane(W).Manufacturer; end;

end MakePlane;
