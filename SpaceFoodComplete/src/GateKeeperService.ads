with Food_DataStructures;  use Food_DataStructures;
With Stats_FoodDistribution;  use Stats_FoodDistribution;
with DoubleStack;
with ada.Calendar; use ada.Calendar;

package GateKeeperService is
   function getCapacity return Integer;
   procedure finalReport(soldmeat: in Integer; soldveg: in Integer; vegGenerated: in Integer; meatGenerated: in Integer; startTime: in ada.Calendar.Time);

   procedure getPrice(meatPrice :in out Integer; vegPrice:in out Integer);

  task GateKeeper is
      -- accept Food_Packs from interplanetary vesssels.
      entry acceptMessage( newFood: in Food_Pack );

      --Allow sales to retrive the repackaged Food_Packs.
      entry retrieveMessage( newFood: out Food_Pack; availableForShipment: out Boolean );

   end GateKeeper;

end GateKeeperService;
