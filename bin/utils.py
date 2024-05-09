import matplotlib.pyplot as plt 
def plot_forecasts(forecast_it, ts_it,predciton_length, save_figname):
    prediction_intervals = (50.0, 90.0)
    legend = ["observations", "median prediction"] + [f"{k}% prediction interval" for k in prediction_intervals][::-1]
    fig, ax = plt.subplots(1, 1, figsize=(10, 7))
    list(ts_it)[0][-predciton_length*2:].plot(ax=ax)  
    forecast_it[0].plot(prediction_intervals, color='g')
    plt.grid(which="both")  
    plt.legend(legend, loc="upper left")
    plt.savefig(save_figname)