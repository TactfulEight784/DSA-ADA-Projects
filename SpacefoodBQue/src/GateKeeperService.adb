with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Calendar;  use Ada.Calendar;


package body GateKeeperService is

   package IntegerIO is new Ada.Text_IO.Integer_IO(Integer);  use IntegerIO;

   function getCapacity return Integer is
   capacityIn:Natural;
   begin
      put("How much space do you have?  "); get(capacityIn);  -- number receiving stations.
      new_line;
      return capacityIn;
   end getCapacity;

   task body GateKeeper is

      package CircularQueue is new CircularQue (Food_Pack,getCapacity); -- **  specify size for storage space. **
      use CircularQueue;
      meat : Integer :=0;
      veg : Integer :=0;
      numbersoldmeat : Integer :=0;
      numbersoldveg : Integer := 0;
      rejected: Integer := 0;
      -- Declare food packet counters here.

      Start_Time: Ada.Calendar.Time;
      End_Time:   Ada.Calendar.Time;

   begin

      delay 0.5;  -- allow 1/2 hour to initialize facility.
      Start_Time := Ada.Calendar.Clock;
      End_Time := Start_Time + 1.0 * 8.0 * 5.0; -- 1.0 sec./hour * 8 hours/days * 5 days

      -- Termiate after lossing 5 customers or time to close has arrived.
      while rejected < 5 and Ada.Calendar.Clock < End_Time loop  -- Termiate after lossing 5 customers

         -- In Ada, a "select" statement with multiple "or" options must uniformly
         -- process (randomly) the "accept" statements.  This prevents any single
         -- "accept" from starving the others from service.
         --
         -- Rules for "Select":
         -- 1) If no task are waiting for service, the task sleeps.
         -- 2) If only one of the "accept" entries has a task waiting that task is served.
         -- 3) If sleeping and a task or tasks arrive simultaneously, awake a service the
         --    the first arrival.
         -- 4) If multiple "accepts" have task waiting, service them in random order
         --    to prevent starvation.
         --

         select
            -- new arrivals of food
            accept acceptMessage( newFood: in Food_Pack) do
               if not( CircularQueFull ) then
                  if(getFood_PackFoodType(newfood) in GrainVegetable)then --counts how much meat and veg are generated
                     veg := veg +1;
                  else meat:= meat+1;
                  end if;
                  CircularQueue.acceptMessage( newFood);
                  put("GateKeeper insert accepted ");
                  PrintFood_Pack( newFood ); new_line;
               else
                  rejected := rejected + 1;
                  put(" Rejected by GateKeeper: "); new_line;
                  PrintFood_Pack( newFood ); new_line;
                  put(" Rejected = "); put(rejected);
                  put(". Sent to another distribution facility!"); new_line(3);
               end if;
            end acceptMessage;
         or
            -- Accept request for distribution from sales
            accept retrieveMessage( newFood: out Food_Pack; availableForShipment: out Boolean) do
              availableForShipment := False;
              if not(CircularQueue.circularQueEmpty) then
                 availableForShipment := True;
                 CircularQueue.retrieveMessage( newFood );
                  PrintFood_Pack( newFood ); put(" Removed by GateKeeper for shipment."); new_line;
                   if (getFood_PackFoodType(newfood) in GrainVegetable)then -- this if counts how many meat and veg sold
                     numbersoldveg := numbersoldveg +1;
                   else numbersoldmeat := numbersoldmeat +1;
                   end if;
              end if;
            end retrieveMessage;
         end select;

         delay 1.1; -- Complete overhead due to accepting or rejecting a request prior to new iteration.
      end loop;

      put("total meat packets sold");
      Ada.Text_IO.Put_Line(Integer'Image(numbersoldmeat)); --gives me total meat sold
      put("total veg packets sold");
      Ada.Text_IO.Put_Line(Integer'Image(numbersoldveg)); --gives me total veg sold
      put("number of veg packets generated");
      Ada.Text_IO.Put_Line(Integer'Image(veg)); --gives total veg generated
      new_Line(1); put("number of meat packets generated");
      Ada.Text_IO.Put_Line(Integer'Image(meat)); --gives total meat generated
      -- print time in service, statistics such as number food pacekets of meat and non-meat products processed.
      new_line(2);  put("Hours of operation prior to closing: ");
      Ada.Text_IO.Put_Line(Duration'Image(Ada.Calendar.Clock - Start_Time)); new_line(2);

   end GateKeeper;
end GateKeeperService;
