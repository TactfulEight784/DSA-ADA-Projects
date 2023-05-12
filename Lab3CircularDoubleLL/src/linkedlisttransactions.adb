with Linkedlist;
with MakeCar, MakePlane; use MakeCar, MakePlane;
with Ada.Unchecked_Deallocation;
with Ada.Text_IO; use Ada.Text_IO;

procedure linkedlisttransactions is
  type DLPtr is access all vehical'Class;
   procedure Free is new Ada.Unchecked_Deallocation(vehical'Class, DLPtr);

   function isEqual(V : in vehical'Class; W : in vehical'Class) return Boolean is
  begin
     return equality(V, W);      -- returns the result of the overridden equality function it needs to use
  end;

  procedure PrintedItem(pItem : vehical'Class) is
   begin
      PrintItem(pItem);  --prints the items depending on the overriden funciton it uses
   end;

  package VehicleList is new Linkedlist(vehical, isEqual);
  use VehicleList;

  procedure PrintList is new ManuealMove(PrintedItem);

   list : DList;
   doors:Integer;
   engines:Integer;
   manufactCar:string(1..4);
   ManufactPlane:string(1..8);
  V : access vehical'Class;
  C : access Car;
  P : access Plane;
  K : aliased Car;  --allows access to the values in car so it can actually search for the correct cars

begin
   makeHead(list); -- begin with null head node

   ManufactCar := MakeCar.UserString; --input manufact
   doors := MakeCar.NumberDoors; --input num of doors
   C := new Car'(vehical with doors  , manufactCar );
   InsertBefore(list, elementPtr(C));

   ManufactCar := MakeCar.UserString; --input manufact
   doors := MakeCar.NumberDoors; --input num of doors
   C := new Car'(vehical with doors  , manufactCar);
   InsertAfter(list, elementPtr(C));

   ManufactCar := MakeCar.UserString; --input manufact
   doors := MakeCar.NumberDoors; --input num of doors
   C := new Car'(vehical with doors  , manufactCar);
   InsertBefore(list, elementPtr(C));

   ManufactCar := MakeCar.UserString; --input manufact
   doors := MakeCar.NumberDoors; --input num of doors
   C := new Car'(vehical with doors  , manufactCar);
   InsertBefore(list, elementPtr(C));

   ManufactCar := MakeCar.UserString; --input manufact
   doors := MakeCar.NumberDoors; --input num of doors
   C := new Car'(vehical with doors  , manufactCar);
   InsertAfter(list, elementPtr(C));


   Put_Line("List size: " & ListSize(list)'Img);


   Put_Line("list Contents: ");
   PrintList(list); New_Line;

   ManufactCar := MakeCar.UserString;
   Skip_Line;--input manufact
   K := Car'(-1, ManufactCar);
   V := FindItem(list, K'Access);
   V := Delete(list, K'Access);

   --i
   Put_Line("List size: " & ListSize(list)'Img); New_Line;


   Put_Line("List Content: ");
   PrintList(list);  New_Line;


   ManufactPlane := MakePlane.UserString; --input manufact
   doors := MakePlane.NumberDoors; --input num of doors
   engines := makePlane.NumberEngines;
   P := new Plane'(vehical with doors, engines, ManufactPlane);
   InsertAfter(list, elementPtr(P));

   ManufactPlane := MakePlane.UserString; --input manufact
   doors := MakePlane.NumberDoors; --input num of doors
   engines := makePlane.NumberEngines;
   P := new Plane'(vehical with doors, engines, ManufactPlane);
   InsertAfter(list, elementPtr(P));

   ManufactPlane := MakePlane.UserString; --input manufact
   doors := MakePlane.NumberDoors; --input num of doors
   engines := makePlane.NumberEngines;
   P := new Plane'(vehical with doors, engines, ManufactPlane);
   InsertAfter(list, elementPtr(P));

   Put_Line("List Contents: ");
   PrintList(list);
end linkedlisttransactions;
