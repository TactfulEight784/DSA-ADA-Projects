with Linkedlist;
package MakeCar is

   type vehical is tagged null record;  --making a single class empty so have access to both child classes at once

    function equality(V : in vehical; W : in vehical'Class) return Boolean;
   procedure PrintItem(V : in vehical);


   type Car is new vehical with record
      NumDoors : Integer;
      Manufacturer : String(1..4);
   end record;

   function UserString return string;

   function NumberDoors return Integer;

   procedure AssignNumDoors(aCar : in out Car; N : in Integer);

   procedure AssignManufacturer(aCar : in out Car; Manu : in String);

   procedure PrintDoors(aCar : in Car);

   procedure PrintManufacturer(aCar : in Car);

   procedure identify(aCar : in Car);

   overriding procedure PrintItem(acar : in Car);
   overriding function equality(aCar : in Car; V : in vehical'Class) return Boolean;

end MakeCar;
