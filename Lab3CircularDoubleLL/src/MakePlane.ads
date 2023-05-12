with linkedList;
with MakeCar; use MakeCar;
package MakePlane is

   type Plane is new vehical with record
      NumDoors : Integer;
      NumEngines : Integer;
      Manufacturer : String(1..8);
   end record;

   function UserString return string;

   function NumberDoors return Integer;

   function NumberEngines return Integer;

   procedure AssignNumDoors(aPlane : in out Plane; N : in Integer);

   procedure AssignManufacturer(aPlane : in out Plane; Manu : in String);

   procedure AssignNumEngine(aPlane : in out Plane; NE : in Integer);

   procedure PrintPlane(aPlane : in Plane);

   procedure identify(aPlane: in Plane);

   overriding procedure PrintItem(P : in Plane);


   overriding function equality(P : in Plane; W : in vehical'Class) return Boolean;


end MakePlane;
