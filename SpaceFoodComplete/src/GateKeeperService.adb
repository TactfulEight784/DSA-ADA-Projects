with Ada.Float_Text_IO;
with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Calendar;  use Ada.Calendar;


package body GateKeeperService is

   package IntegerIO is new Ada.Text_IO.Integer_IO(Integer);  use IntegerIO;

   function getCapacity return Integer is
   capacityIn:Natural;
   begin
      delay 0.2;
      put("How much space do you have?  "); get(capacityIn);  -- number receiving stations.
      new_line;
      return capacityIn;
   end getCapacity;

   procedure getPrice(meatPrice :in out Integer; vegPrice : in out Integer) is
   begin
      put("How much does each meat packet cost(Please enter a whole value): "); get(meatPrice);
      New_Line;
      put("How much does each vegetable packet cost(Please enter a whole number): "); get(vegPrice);
      New_Line;
   end getPrice;

   procedure finalReport(soldmeat: in Integer; soldveg: in Integer; vegGenerated: in Integer; meatGenerated: in Integer; startTime: in Time) is
      meatPrice :Integer := 0;
      vegPrice:Integer := 0;
   begin
      getPrice (meatPrice, vegPrice);
      put("Here is your report for the day"); New_Line(2);
      put("Total meat packets sold:");
      Ada.Text_IO.Put_Line(Integer'Image(soldmeat)); --gives me total meat sold
      New_Line(1); put("Total veg packets sold: ");
      Ada.Text_IO.Put_Line(Integer'Image(soldveg)); --gives me total veg sold
      New_Line(1); put("Total sold: ");
      ada.Text_IO.Put_Line(Integer'Image(soldveg + soldmeat));
      New_Line(1); put("Number of veg packets generated: ");
      Ada.Text_IO.Put_Line(Integer'Image(vegGenerated)); --gives total veg generated
      new_Line(1); put("Number of meat packets generated: ");
      Ada.Text_IO.Put_Line(Integer'Image(meatGenerated)); --gives total meat generated
      New_Line(1); put("Total number of packets generated: ");
      ada.Text_IO.Put_Line(Integer'Image(vegGenerated + meatGenerated));
      New_Line(1); put("Total pofit from packets sold today: ");
      ada.Text_IO.Put_Line(Integer'Image((soldveg*vegPrice )+(soldmeat*meatPrice)));
      new_line(1);  put("Hours of operation prior to closing: ");
      Ada.Text_IO.Put_Line(Duration'Image(Ada.Calendar.Clock - startTime)); new_line(2);
   end finalReport;


   task body GateKeeper is



      package DoubleStacks is new DoubleStack (Food_Pack, getCapacity); -- **  specify size for storage space. **
      use DoubleStacks;
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
               if  ( DoubleStacks.spaceAvailable ) then
                  if(getFood_PackFoodType(newfood) in GrainVegetable)then --counts how much meat and veg are generated
                     DoubleStacks.vegpush(newfood);
                     PrintFood_Pack( newFood ); new_line;
                     veg := veg +1;
                    -- Ada.Text_IO.Put_Line(Integer'Image(veg));
                  else
                     DoubleStacks.meatpush(newfood);
                     PrintFood_Pack( newFood ); new_line;
                     meat := meat +1;
                  end if;
                  -- get food packet food type in food data structures
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
              if not(DoubleStacks.StackEmpty) then
                 availableForShipment := True;
                 DoubleStacks.retrieveMessage( newFood );
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

      finalReport(numbersoldmeat, numbersoldveg, veg, meat, Start_Time);

   end GateKeeper;
end GateKeeperService;
