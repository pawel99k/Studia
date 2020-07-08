import dash
from dash.dependencies import Input, Output, State
import dash_core_components as dcc
import dash_html_components as html
import dash_bootstrap_components as dbc
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import pandas as pd
import numpy as np
import chaospy as cp
from scipy import integrate
from functions import model_fun1, model_fun2, model_fun3, model_fun4

data = pd.read_csv('populations_data.csv', index_col=0)


def make_plot(t, ode_sol, model, magnitude, results=None, start_val = None):
    if model == 'model1':
        fig = make_subplots(rows=1, cols=2, column_widths=[0.7, 0.3])
        fig.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 0], name="Podatni",
                                 customdata=[(i * 24) % 24 for i in t],
                                 text=[(i * 24 * 60) % 60 for i in t],
                                 hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                      row=1, col=1)
        fig.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 1], name="Zombie",
                                 customdata=[(i * 24) % 24 for i in t],
                                 text=[(i * 24 * 60) % 60 for i in t],
                                 hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                      row=1, col=1)
        fig.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 2], name="Prawdziwie umarli",
                                 customdata=[(i * 24) % 24 for i in t],
                                 text=[(i * 24 * 60) % 60 for i in t],
                                 hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                      row=1, col=1)
        fig.add_trace(go.Bar(x=['Podatni', 'Zombie', 'Prawdziwie umarli'], y=np.array(results)/magnitude,
                             marker_color=['blue', 'red', 'green'], showlegend=False,
                             hovertemplate='%{x}: %{y:.2f} <extra></extra>'), row=1, col=2)

        annotations = [
            dict(xref='paper', yref='paper', y=-0.15,
                 x=0.001, yanchor='bottom',
                 text=f'Początkowa liczebność populacji żywych: {round(start_val[0] * magnitude)}, populacji prawdziwie zmarłych: {round(start_val[2] * magnitude)}',
                 font=dict(family='Arial',
                           size=10,
                           color='rgb(37,37,37)'),
                 showarrow=False),
            dict(xref='paper', yref='paper', y=1.05,
                 x=1, yanchor='bottom',
                 text="Ostateczne liczności populacji wyznaczone analitycznie",
                 font=dict(family='Arial',
                           size=20,
                           color='rgb(37,37,37)'),
                 showarrow=False),
            dict(xref='paper', yref='paper', y=1.05,
                 x=0.15, yanchor='bottom',
                 text='Podstawowy model przebiegu inwazji zombie',
                 font=dict(family='Arial',
                           size=20,
                           color='rgb(37,37,37)'),
                 showarrow=False)
        ]
        if magnitude > 1:
            fig.update_layout(template="plotly_white", yaxis_title="Liczność populacji ({:.0e})".format(magnitude),
                              xaxis_title="Dzień inwazji", annotations = annotations)
        else:
            fig.update_layout(template="plotly_white",
                              yaxis_title="Liczność populacji",
                              xaxis_title="Dzień inwazji", annotations = annotations)
        return fig
    if model == 'model2':
        fig2 = make_subplots(rows=1, cols=2, column_widths=[0.7, 0.3])
        fig2.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 0], name="Podatni",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig2.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 1], name="Zainfekowani",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'), row=1, col=1)
        fig2.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 2], name="Zombie",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig2.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 3], name="Prawdziwie umarli",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig2.add_trace(go.Bar(x=['Podatni', 'Zainfekowani', 'Zombie', 'Prawdziwie umarli'],y=np.array(results)/magnitude,
                             marker_color=['blue', 'red', 'green', 'purple'], showlegend=False,
                             hovertemplate='%{x}: %{y:.2f} <extra></extra>'), row=1, col=2)
        annotations = [
            dict(xref='paper', yref='paper', y=-0.15,
                 x=0.001, yanchor='bottom',
                 text=f'Początkowa liczebność populacji żywych: {round(start_val[0]*magnitude)}, populacji prawdziwie zmarłych: {round(start_val[3]*magnitude)}',
                 font=dict(family='Arial',
                           size=10,
                           color='rgb(37,37,37)'),
                 showarrow=False),
            dict(xref='paper', yref='paper', y=1.05,
                 x=1, yanchor='bottom',
                 text="Ostateczne liczności populacji wyznaczone analitycznie",
                 font=dict(family='Arial',
                           size=20,
                           color='rgb(37,37,37)'),
                 showarrow=False),
            dict(xref='paper', yref='paper', y=1.05,
                x=0.15, yanchor='bottom',
                text='Model inwazji zombie z pewnym okresem rozwoju zakażenia',
                font=dict(family='Arial',
                           size=20,
                           color='rgb(37,37,37)'),
                showarrow=False)
        ]

        if magnitude > 1:
            fig2.update_layout(template="plotly_white", annotations = annotations,
                               yaxis_title="Liczność populacji ({:.0e})".format(magnitude),
                               xaxis_title="Dzień inwazji")
        else:
            fig2.update_layout(template="plotly_white", annotations = annotations,
                               yaxis_title="Liczność populacji",
                               xaxis_title="Dzień inwazji")
        return fig2
    if model == 'model3':
        fig3 = make_subplots(rows=1, cols=2, column_widths=[0.7, 0.3])
        fig3.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 0], name="Podatni",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig3.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 1], name="Zainfekowani",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig3.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 2], name="Zombie",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig3.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 3], name="Prawdziwie umarli",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig3.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 4], name="Izolowani",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig3.add_trace(go.Bar(x=['Podatni', 'Zainfekowani', 'Zombie', 'Prawdziwie umarli', 'Izolowani'], y=np.array(results)/magnitude,
                             marker_color=['blue', 'red', 'green', 'purple', 'orange'], showlegend=False,
                             hovertemplate='%{x}: %{y:.2f} <extra></extra>'), row=1, col=2)

        annotations = [
            dict(xref='paper', yref='paper', y=-0.15,
                 x=0.001, yanchor='bottom',
                 text=f'Początkowa liczebność populacji żywych: {round(start_val[0] * magnitude)}, populacji prawdziwie zmarłych: {round(start_val[3] * magnitude)}',
                 font=dict(family='Arial',
                           size=10,
                           color='rgb(37,37,37)'),
                 showarrow=False),
            dict(xref='paper', yref='paper', y=1.05,
                 x=1, yanchor='bottom',
                 text="Ostateczne liczności populacji wyznaczone analitycznie",
                 font=dict(family='Arial',
                           size=20,
                           color='rgb(37,37,37)'),
                 showarrow=False),
            dict(xref='paper', yref='paper', y=1.05,
                 x=0.15, yanchor='bottom',
                 text='Model inwazji zombie z kwarantanną',
                 font=dict(family='Arial',
                           size=20,
                           color='rgb(37,37,37)'),
                 showarrow=False)
        ]
        if magnitude > 1:
            fig3.update_layout(template="plotly_white",
                               yaxis_title="Liczność populacji ({:.0e})".format(magnitude),
                               xaxis_title="Dzień inwazji", annotations = annotations)
        else:
            fig3.update_layout(template="plotly_white",
                               yaxis_title="Liczność populacji",
                               xaxis_title="Dzień inwazji", annotations = annotations)
        return fig3
    if model == 'model4':
        fig4 = make_subplots(rows=1, cols=2, column_widths=[0.7, 0.3],
                             subplot_titles=("Podstawowy model przebiegu inwazji zombie",
                                             "Ostateczne liczności populacji wyznaczone analitycznie"))
        fig4.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 0], name="Podatni",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig4.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 1], name="Zainfekowani",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig4.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 2], name="Zombie",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig4.add_trace(go.Scatter(x=t, y=ode_sol.sol(t).T[:, 3], name="Prawdziwie umarli",
                                  customdata=[(i * 24) % 24 for i in t],
                                  text=[(i * 24 * 60) % 60 for i in t],
                                  hovertemplate='Dzień: %{x:.2f}<br>Godzina: %{customdata:.0f}:%{text:.0f}<br>Populacja: %{y:.2f}'),
                       row=1, col=1)
        fig4.add_trace(go.Bar(x=['Podatni', 'Zainfekowani', 'Zombie', 'Prawdziwie umarli'], y=np.array(results)/magnitude,
                             marker_color=['blue', 'red', 'green', 'purple'], showlegend=False,
                             hovertemplate='%{x}: %{y:.2f} <extra></extra>'), row=1, col=2)
        annotations = [
            dict(xref='paper', yref='paper', y=-0.15,
                 x=0.001, yanchor='bottom',
                 text=f'Początkowa liczebność populacji żywych: {round(start_val[0] * magnitude)}, populacji prawdziwie zmarłych: {round(start_val[3] * magnitude)}',
                 font=dict(family='Arial',
                           size=10,
                           color='rgb(37,37,37)'),
                 showarrow=False),
            dict(xref='paper', yref='paper', y=1.05,
                 x=1, yanchor='bottom',
                 text="Ostateczne liczności populacji wyznaczone analitycznie",
                 font=dict(family='Arial',
                           size=20,
                           color='rgb(37,37,37)'),
                 showarrow=False),
            dict(xref='paper', yref='paper', y=1.05,
                 x=0.15, yanchor='bottom',
                 text='Model inwazji zombie z wynalezionym leczeniem',
                 font=dict(family='Arial',
                           size=20,
                           color='rgb(37,37,37)'),
                 showarrow=False)
        ]
        if magnitude > 1:
            fig4.update_layout(template="plotly_white",
                               yaxis_title="Liczność populacji ({:.0e})".format(magnitude),
                               xaxis_title="Dzień inwazji", annotations = annotations)
        else:
            fig4.update_layout(template="plotly_white",
                               yaxis_title="Liczność populacji",
                               xaxis_title="Dzień inwazji", annotations = annotations)
        return fig4
    fig = go.Figure()
    fig.update_layout(template='plotly_white')
    return fig


app = dash.Dash(__name__)

app.layout = html.Div(children=[
    html.H1(children='Inwazja zombie!'),
    html.Div(children=[
        html.Label('Wybierz odpowiedni model:'),
        dcc.Dropdown(id='model',
                     options=[
                         {'label': 'Podstawowy model przebiegu inwazji zombie', 'value': 'model1'},
                         {'label': 'Model inwazji zombie z pewnym okresem rozwoju zakażenia', 'value': 'model2'},
                         {'label': 'Model inwazji zombie z kwarantanną', 'value': 'model3'},
                         {'label': 'Model inwazji zombie z wynalezionym leczeniem', 'value': 'model4'}],
                     style = {'margin': '15px', 'width': '96%'})
    ]),
    html.Div([
    html.Div([
        html.Label('Wybierz, gdzie ma miejsce inwazja:', id='warunki_poczatkowe_label', style = {'text-align': 'center'}),
        dcc.Dropdown(id='podatni',
                     options=[{'label': 'Warszawa',
                               'value': data.loc[data['City'] == 'Warszawa', 'Population'].values[0]}] +
                             [{'label': data.loc[i, 'City'], 'value': data.loc[i, 'Population']} for i in
                              range(data.shape[0]) if data.loc[i, 'City'] != 'Warszawa'],
                     style=dict(width="50%", display='block')),
        html.Div([
            dcc.Input(
                id="input_podatni",
                type='number',
                placeholder="Początkowa liczba osób podatnych",
                style={'display': 'none'}
            ),
            dcc.Input(
                id="input_infected",
                type='number',
                placeholder="Początkowa liczba osób zainfekowanych",
                style={'display': 'none'}
            ),
            dcc.Input(
                id="input_zombie",
                type='number',
                placeholder="Początkowa liczba zombie",
                style={'display': 'none'}
            ),
            dcc.Input(
                id="input_removed",
                type='number',
                placeholder="Początkowa liczba osób umarłych",
                style={'display': 'none'}
            ),
            dcc.Input(
                id="input_izolowani",
                type='number',
                placeholder="Początkowa liczba osób izolowanych",
                style={'display': 'none'}
            ),
            html.Button("Zatwierdź dane", id='zatwierdz', style={'display': 'none'})
        ], className = 'flex2'),
        html.Button('Zmień opcje wprowadzania danych początkowych', id='dane_poczatkowe')], className = 'flex2'),
    html.Div([
    html.Div(
        id='a', children=
        ['Określ szanse na pokonanie zombie przez osobę podatną w bezpośrednim starciu',
         dcc.Slider(
             id='a-slider',
             min=0.05,
             max=0.95,
             step=0.05,
             value=0.5,
             marks={0.05: '0.05', 0.1: '0.1', 0.2: '0.2', 0.3: '0.3', 0.4: '0.4', 0.5: '0.5', 0.6: '0.6', 0.7: '0.7',
                    0.8: '0.8', 0.9: '0.9', 0.95: '0.95'}
         )],
        style={'display': 'block'}
    ),
    html.Div(
        id='b', children=
        ['Określ odsetek populacji, z jakimi przeciętna osoba ma kontakt wystarczający do zarażenia',
         dcc.Slider(
             id='b-slider',
             min=0.05,
             max=0.95,
             step=0.05,
             value=0.5,
             marks={0.05: '0.05', 0.1: '0.1', 0.2: '0.2', 0.3: '0.3', 0.4: '0.4', 0.5: '0.5', 0.6: '0.6', 0.7: '0.7',
                    0.8: '0.8', 0.9: '0.9', 0.95: '0.95'}
         )],
        style={'display': 'block'}
    ),
    html.Div(
        id='c', children=
        ['Określ stałą okreslajacą odsetek liczby osób ponownie wskrzeszonych do życia w jednostce czasu',
         dcc.Slider(
             id='c-slider',
             min=0.05,
             max=0.95,
             step=0.05,
             value=0.5,
             marks={0.05: '0.05', 0.1: '0.1', 0.2: '0.2', 0.3: '0.3', 0.4: '0.4', 0.5: '0.5', 0.6: '0.6', 0.7: '0.7',
                    0.8: '0.8', 0.9: '0.9', 0.95: '0.95'}
         )],
        style={'display': 'block'}
    ),
    html.Div(
        id='p', children=
        ['Określ tempo rozwoju zakażenia w organiźmie',
         dcc.Slider(
             id='p-slider',
             min=0.05,
             max=0.95,
             step=0.05,
             value=0.5,
             marks={0.05: '0.05', 0.1: '0.1', 0.2: '0.2', 0.3: '0.3', 0.4: '0.4', 0.5: '0.5', 0.6: '0.6', 0.7: '0.7',
                    0.8: '0.8', 0.9: '0.9', 0.95: '0.95'}
         )],
        style={'display': 'block'}
    ),
    html.Div(
        id='k', children=
        ['Określ stałą okreslajacą odsetek populacji zainfekowanych trafiający do kwarantanny',
         dcc.Slider(
             id='k-slider',
             min=0.05,
             max=0.95,
             step=0.05,
             value=0.5,
             marks={0.05: '0.05', 0.1: '0.1', 0.2: '0.2', 0.3: '0.3', 0.4: '0.4', 0.5: '0.5', 0.6: '0.6', 0.7: '0.7',
                    0.8: '0.8', 0.9: '0.9', 0.95: '0.95'}
         )],
        style={'display': 'block'}
    ),
    html.Div(
        id='y', children=
        ['Określ stałą okreslajacą odsetek populacji osób na kwarantannie, które nieudolnie próbujac wydostać się '
         'na wolność, trafiają do populacji prawdziwie zmarłych',
         dcc.Slider(
             id='y-slider',
             min=0.05,
             max=0.95,
             step=0.05,
             value=0.5,
             marks={0.05: '0.05', 0.1: '0.1', 0.2: '0.2', 0.3: '0.3', 0.4: '0.4', 0.5: '0.5', 0.6: '0.6', 0.7: '0.7',
                    0.8: '0.8', 0.9: '0.9', 0.95: '0.95'}
         )],
        style={'display': 'block'}
    ),
    html.Div(
        id='u', children=
        ['Określ stałą okreslajacą odsetek populacji zombie trafiający do kwarantanny',
         dcc.Slider(
             id='u-slider',
             min=0.05,
             max=0.95,
             step=0.05,
             value=0.5,
             marks={0.05: '0.05', 0.1: '0.1', 0.2: '0.2', 0.3: '0.3', 0.4: '0.4', 0.5: '0.5', 0.6: '0.6', 0.7: '0.7',
                    0.8: '0.8', 0.9: '0.9', 0.95: '0.95'}
         )],
        style={'display': 'block'}
    ),
    html.Div(
        id='c2', children=
        ['Określ stałą okreslajacą odsetek populacji zombie przywróconych do życia przy pomocy lekarstwa '
         '(bez nabycia odporności)',
         dcc.Slider(
             id='c2-slider',
             min=0.05,
             max=0.95,
             step=0.05,
             value=0.5,
             marks={0.05: '0.05', 0.1: '0.1', 0.2: '0.2', 0.3: '0.3', 0.4: '0.4', 0.5: '0.5', 0.6: '0.6', 0.7: '0.7',
                    0.8: '0.8', 0.9: '0.9', 0.95: '0.95'}
         )],
        style={'display': 'block'}
    )], className= 'flex2' )], className = "flex-container"),
    dcc.Loading(
        dcc.Graph(
            id='example-graph'
        ),
        type='graph'
    )
])


@app.callback(
    [Output(component_id='p', component_property='style'),
     Output(component_id='k', component_property='style'),
     Output(component_id='y', component_property='style'),
     Output(component_id='u', component_property='style'),
     Output(component_id='c2', component_property='style')],
    [Input(component_id='model', component_property='value')])
def show_hide_element(chosen_model):
    if chosen_model == 'model1':
        return [{'display': 'none'},
                {'display': 'none'}, {'display': 'none'}, {'display': 'none'}, {'display': 'none'}]
    elif chosen_model == 'model2':
        return [{'display': 'block'},
                {'display': 'none'}, {'display': 'none'}, {'display': 'none'}, {'display': 'none'}]
    elif chosen_model == 'model3':
        return [{'display': 'block'},
                {'display': 'block'}, {'display': 'block'}, {'display': 'block'}, {'display': 'none'}]
    elif chosen_model == 'model4':
        return [{'display': 'block'},
                {'display': 'none'}, {'display': 'none'}, {'display': 'none'}, {'display': 'block'}]
    else:
        return [{'display': 'none'},
                {'display': 'none'}, {'display': 'none'}, {'display': 'none'}, {'display': 'none'}]


@app.callback(Output(component_id='example-graph', component_property='figure'),
              [Input(component_id='model', component_property='value'),
               Input(component_id='a-slider', component_property='value'),
               Input(component_id='b-slider', component_property='value'),
               Input(component_id='c-slider', component_property='value'),
               Input(component_id='p-slider', component_property='value'),
               Input(component_id='k-slider', component_property='value'),
               Input(component_id='y-slider', component_property='value'),
               Input(component_id='u-slider', component_property='value'),
               Input(component_id='c2-slider', component_property='value'),
               Input(component_id='podatni', component_property='value'),
               Input('zatwierdz', 'n_clicks')],
              [State('input_podatni', 'value'),
               State('input_infected', 'value'),
               State('input_zombie', 'value'),
               State('input_removed', 'value'),
               State('input_izolowani', 'value'),
               State(component_id='podatni', component_property='value')])
def update_graph_element(model, a_val, b_val, c_val, p_val, k_val, y_val, u_val, c2_val, podatni, zatwierdz, s0_input,
                         i0_input, z0_input, r0_input, q0_input, podatni_state):

    trigger = dash.callback_context.triggered[0]['prop_id'].split('.')[0]
    if trigger == 'zatwierdz':
        s0 = s0_input if s0_input is not None else 0
        i0 = i0_input if i0_input is not None else 0
        z0 = z0_input if z0_input is not None else 0
        r0 = r0_input if r0_input is not None else 0
        q0 = q0_input if q0_input is not None else 0
    elif trigger == 'podatni':
        s0 = podatni
        z0 = 0.001 * s0
        r0 = 0.1 * s0
        i0 = 0
        q0 = 0
    else:
        s0 = s0_input if s0_input is not None else podatni_state
        if s0 is None:
            s0 = 100
        z0 = z0_input if z0_input is not None else 0.001 * s0
        r0 = r0_input if r0_input is not None else 0.1 * s0
        i0 = i0_input if i0_input is not None else 0
        q0 = q0_input if q0_input is not None else 0

    # wartości w mln bardzo długo się liczą, więc będzie trzeba dać po kilkaset i w nawiasie, że liczby w mln
    # tak samo jednostkę czasu by się przydało określić (pewnie dni)
    magnitude = 0
    if s0 > 1000000000:
        new_s0 = s0 / 1000000000  #
        new_z0 = z0 / 1000000000  #
        new_r0 = r0 / 1000000000  #
        new_i0 = i0 / 1000000000  #
        new_q0 = q0 / 1000000000  #
        magnitude = 1000000000
    elif s0 > 1000000:
        new_s0 = s0 / 1000000  #
        new_z0 = z0 / 1000000  #
        new_r0 = r0 / 1000000  #
        new_i0 = i0 / 1000000  #
        new_q0 = q0 / 1000000  #
        magnitude = 1000000
    elif s0 > 1000:
        new_s0 = s0 / 1000  #
        new_z0 = z0 / 1000  #
        new_r0 = r0 / 1000  #
        new_i0 = i0 / 1000  #
        new_q0 = q0 / 1000  #
        magnitude = 1000
    else:
        new_s0 = s0
        new_z0 = z0
        new_r0 = r0
        new_i0 = i0
        new_q0 = q0
        magnitude = 1
    if model == 'model1':
        a, b, c = a_val, b_val, c_val
        SZR0 = [new_s0, new_z0, new_r0]
        t = np.linspace(0, 30, 1000)
        ode_sol = integrate.solve_ivp(model_fun1, [0, 300], SZR0, args=(a, b, c), dense_output=True, method="RK45")
        if new_z0 == 0 and new_r0 == 0:
            result = [np.sum(SZR0) * magnitude, 0, 0]
        else:
            result = [0, np.sum(SZR0) * magnitude, 0]

        return make_plot(t, ode_sol, model, magnitude, result, SZR0)
    elif model == 'model2':
        a, b, c, p = a_val, b_val, c_val, p_val
        SIZR0 = [new_s0, new_i0, new_z0, new_r0]
        t = np.linspace(0, 30, 1000)
        ode_sol = integrate.solve_ivp(model_fun2, [0, 150], SIZR0, args=(a, b, c, p), dense_output=True, method="RK45")
        if new_z0 == 0 and new_i0 == 0 and new_r0 == 0:
            result = [np.sum(SIZR0) * magnitude, 0, 0, 0]
        else:
            result = [0, 0, np.sum(SIZR0) * magnitude, 0]
        return make_plot(t, ode_sol, model, magnitude, result, SIZR0)
    elif model == 'model3':
        a, b, c, p, k, y, u = a_val, b_val, c_val, p_val, k_val, y_val, u_val
        SIZRQ0 = [new_s0, new_i0, new_z0, new_r0, new_q0]
        t = np.linspace(0, 30, 1000)
        ode_sol = integrate.solve_ivp(model_fun3, [0, 150], SIZRQ0, args=(a, b, c, p, k, y, u), dense_output=True,
                                      method="RK45")
        if s0 == np.sum(SIZRQ0):
            result = [np.sum(SIZRQ0) * magnitude, 0, 0, 0, 0]
        else:
            result = [0, 0, np.sum(SIZRQ0) / (1 + u / c + u / y) * magnitude,
                      np.sum(SIZRQ0) * (u / c) / (1 + u / c + u / y) * magnitude,
                      np.sum(SIZRQ0) * (u / y) / (1 + u / c + u / y) * magnitude]
        return make_plot(t, ode_sol, model, magnitude, result, SIZRQ0)
    elif model == 'model4':
        a, b, c, p, c2 = a_val, b_val, c_val, p_val, c2_val
        SIZR0 = [s0, i0, z0, r0]  # nie mozemy korzystac z przeskalowanych wartosci tutaj
        t = np.linspace(0, 20, 1000)
        ode_sol = integrate.solve_ivp(model_fun4, [0, 20], SIZR0, args=(a, b, c, p, c2), dense_output=True,
                                      method="RK45")
        if s0 == np.sum(SIZR0) or c2/b > np.sum(SIZR0): #drobny problem z tym drugim warunkiem, ale mozna rozwazyc, ze to rozwiazanie bedzie tak zbiegac
            result = [np.sum(SIZR0) * magnitude, 0, 0, 0]
        else:
            result = [c2 / b, (np.sum(SIZR0) * magnitude - c2 / b) * (c2 / p) / (c2 / p + 1 + a * c2 / (c * b)),
                      (np.sum(SIZR0) * magnitude - c2 / b) / (c2 / p + 1 + a * c2 / (c * b)),
                      (np.sum(SIZR0) * magnitude - c2 / b) * (a * c2 / (c * b)) / (c2 / p + 1 + a * c2 / (c * b))]
        return make_plot(t, ode_sol, model, 1, result, SIZR0)
    else:
        return make_plot(None, None, model, magnitude, None)


@app.callback(
    [Output(component_id='input_podatni', component_property='style'),
     Output(component_id='input_infected', component_property='style'),
     Output(component_id='input_zombie', component_property='style'),
     Output(component_id='input_removed', component_property='style'),
     Output(component_id='input_izolowani', component_property='style'),
     Output(component_id='zatwierdz', component_property='style'),
     Output(component_id='podatni', component_property='style'),
     Output('warunki_poczatkowe_label', 'children'),
     Output('input_podatni', 'value'),
     Output('input_infected', 'value'),
     Output('input_zombie', 'value'),
     Output('input_removed', 'value'),
     Output('input_izolowani', 'value')
     ],
    [Input('dane_poczatkowe', 'n_clicks'),
     Input('model', 'value')],
    [State('podatni', 'style'),
     State('input_podatni', 'value'),
     State('input_infected', 'value'),
     State('input_zombie', 'value'),
     State('input_removed', 'value'),
     State('input_izolowani', 'value')]
)
def update_sth(_, model, podatni_style, val1, val2, val3, val4, val5):
    ctx = dash.callback_context
    if ctx.triggered[0]['prop_id'].split('.')[0] == 'dane_poczatkowe':
        if podatni_style['display'] == 'block':
            if model == "model1":
                return {'display': 'block', 'width': '100%'}, {'display': 'none', 'width': '100%'}, {'display': 'block',
                                                                                                   'width': '100%'}, {
                           'display': 'block', 'width': '100%'}, \
                       {'display': 'none', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {
                           'display': 'none'}, "Podaj warunki początkowe:", val1, val2, val3, val4, val5
            if model == "model2":
                return {'display': 'block', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {'display': 'block',
                                                                                                    'width': '100%'}, {
                           'display': 'block', 'width': '100%'}, \
                       {'display': 'none', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {
                           'display': 'none'}, "Podaj warunki początkowe:", val1, val2, val3, val4, val5
            if model == "model3":
                return {'display': 'block', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {'display': 'block',
                                                                                                    'width': '100%'}, {
                           'display': 'block', 'width': '100%'}, \
                       {'display': 'block', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {
                           'display': 'none'}, "Podaj warunki początkowe:", val1, val2, val3, val4, val5
            if model == "model4":
                return {'display': 'block', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {'display': 'block',
                                                                                                    'width': '100%'}, {
                           'display': 'block', 'width': '100%'}, \
                       {'display': 'none', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {
                           'display': 'none'}, "Podaj warunki początkowe:", val1, val2, val3, val4, val5

        return {'display': 'none', 'width': '100%'}, {'display': 'none', 'width': '100%'}, {'display': 'none',
                                                                                          'width': '100%'}, {
                   'display': 'none', 'width': '100%'}, \
               {'display': 'none', 'width': '100%'}, {'display': 'none', 'width': '100%'}, {
                   'display': 'block'}, 'Określ, gdzie ma miejsce inwazja', None, None, None, None, None
    else:
        if podatni_style['display'] == 'block':
            return {'display': 'none', 'width': '100%'}, {'display': 'none', 'width': '100%'}, {'display': 'none',
                                                                                              'width': '100%'}, {
                       'display': 'none', 'width': '100%'}, \
                   {'display': 'none', 'width': '100%'}, {'display': 'none', 'width': '100%'}, {
                       'display': 'block'}, 'Określ, gdzie ma miejsce inwazja', val1, val2, val3, val4, val5
        if model == "model1":
            return {'display': 'block', 'width': '100%'}, {'display': 'none', 'width': '100%'}, {'display': 'block',
                                                                                               'width': '100%'}, {
                       'display': 'block', 'width': '100%'}, \
                   {'display': 'none', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {
                       'display': 'none'}, "Podaj warunki początkowe:", val1, val2, val3, val4, val5
        if model == "model2":
            return {'display': 'block', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {'display': 'block',
                                                                                                'width': '100%'}, {
                       'display': 'block', 'width': '100%'}, \
                   {'display': 'none', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {
                       'display': 'none'}, "Podaj warunki początkowe:", val1, val2, val3, val4, val5
        if model == "model3":
            return {'display': 'block', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {'display': 'block',
                                                                                                'width': '100%'}, {
                       'display': 'block', 'width': '100%'}, \
                   {'display': 'block', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {
                       'display': 'none'}, "Podaj warunki początkowe:", val1, val2, val3, val4, val5
        if model == "model4":
            return {'display': 'block', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {'display': 'block',
                                                                                                'width': '100%'}, {
                       'display': 'block', 'width': '100%'}, \
                   {'display': 'none', 'width': '100%'}, {'display': 'block', 'width': '100%'}, {
                       'display': 'none'}, "Podaj warunki początkowe:", val1, val2, val3, val4, val5


if __name__ == '__main__':
    app.run_server(debug=True)
